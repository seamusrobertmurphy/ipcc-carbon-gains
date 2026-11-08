"""Post-render step for the Word file, run by Quarto after every render (see
01.manuscript/_quarto.yml).

1. Table rows. Body rows are at least 0.7 cm high with text left aligned, and header rows
   at least 0.9 cm high with text centred. Font size and bold come from the Catena
   reference document.
2. Header units. A header written as a name followed by a unit in parentheses, such as
   "Gain (t CO2 ha-1 yr-1)", has the unit moved to its own line under the name.
3. Column widths. Every data table is set to AutoFit, and each column is given the width
   of its longest text, measured with the letter widths of Word's own Arial, so that every
   body row and every header name takes one line.
4. Landscape pages. A table too wide for a portrait page is placed, with its caption and
   the notes printed under it, in a landscape section. Wide tables separated only by notes,
   captions or empty lines share one section. Page numbers and line numbers run on through
   every section.
5. Title page. An empty paragraph follows the author block and another follows the
   abstract, as Seamus set them in Word on 8 November 2026.
"""
import html, os, re, shutil, zipfile

outputs = os.environ.get("QUARTO_PROJECT_OUTPUT_FILES", "")
targets = [f for f in outputs.split("\n") if f.endswith(".docx")]
if not targets and os.path.exists("Manuscript.docx"):
    targets = ["Manuscript.docx"]

CM = 567                                  # twips per centimetre
BODY, HEAD = int(0.7 * CM), int(0.9 * CM)
ROOM_P = 11906 - 2 * 1440 - 216           # A4 portrait text width, less the cell margins
ROOM_L = 16838 - 2 * 1440 - 216           # of the frame Quarto puts round a main table
PAD = 216 + 60                            # cell margins of the Table style, and a margin of safety
SIZE = 8                                  # table text in points, from the Compact style

# Advance widths of Word's own Arial and Arial Bold for the characters from space (32) to
# tilde (126), in thousandths of an em, read from arial.ttf and arialbd.ttf in Word's DFonts
# folder on 8 November 2026. Any other character is counted at the width of a digit.
ARIAL = [
    278, 278, 355, 556, 556, 890, 667, 191, 333, 333, 390, 585, 278, 333, 278, 278, 556,
    556, 556, 556, 556, 556, 556, 556, 556, 556, 277, 278, 584, 585, 584, 556, 1015, 667,
    666, 723, 722, 667, 611, 778, 723, 278, 501, 667, 556, 833, 722, 778, 667, 778, 722,
    666, 610, 723, 667, 944, 667, 667, 611, 278, 278, 278, 469, 557, 333, 556, 556, 500,
    556, 557, 277, 556, 556, 222, 222, 500, 222, 832, 556, 556, 556, 556, 333, 500, 278,
    556, 500, 722, 500, 500, 500, 334, 260, 334, 584]
ARIAL_BOLD = [
    278, 333, 474, 557, 556, 889, 722, 237, 332, 333, 389, 584, 277, 333, 278, 278, 556,
    556, 556, 556, 556, 556, 556, 556, 556, 556, 333, 333, 583, 584, 583, 611, 975, 722,
    721, 722, 722, 667, 611, 778, 722, 278, 556, 723, 611, 833, 722, 777, 667, 778, 721,
    667, 611, 723, 667, 944, 667, 667, 612, 333, 278, 333, 584, 556, 333, 556, 611, 555,
    610, 556, 333, 611, 610, 278, 278, 556, 278, 890, 611, 611, 611, 610, 389, 555, 332,
    611, 556, 778, 556, 556, 501, 389, 280, 389, 585]


def text(x):
    return html.unescape("".join(re.findall(r"<w:t(?: [^>]*)?>([^<]*)</w:t>", x)))


def style(x):
    m = re.search(r'<w:pStyle w:val="([^"]+)"', x)
    return m.group(1) if m else ""


def twips(s, bold):
    a = ARIAL_BOLD if bold else ARIAL
    return sum(a[ord(c) - 32] if 32 <= ord(c) <= 126 else 556 for c in s) * SIZE * 20 / 1000


def fix_row(row, header):
    h = HEAD if header else BODY
    jc = "center" if header else "left"
    row = re.sub(r'<w:trHeight[^>]*/>', '', row)
    trpr = '<w:trHeight w:val="%d" w:hRule="atLeast" />' % h
    if "<w:trPr>" in row:
        row = row.replace("<w:trPr>", "<w:trPr>" + trpr, 1)
    elif "<w:trPr" in row:
        row = re.sub(r'(<w:trPr[^>]*>)', r'\1' + trpr, row, count=1)
    else:
        row = re.sub(r'(<w:tr[^>]*>)', r'\1<w:trPr>' + trpr + '</w:trPr>', row, count=1)
    row = re.sub(r'<w:jc w:val="[a-z]+" ?/>', '', row)
    row = row.replace("<w:pPr>", '<w:pPr><w:jc w:val="%s" />' % jc)
    return row


def break_unit(cell):
    # The first text run holding " (" is split there, so the parenthesis starts a new line.
    def split(m):
        before, after = m.group(2).split(" (", 1)
        return m.group(1) + before + '</w:t><w:br/><w:t xml:space="preserve">(' + after + m.group(3)
    if " (" not in text(cell) or text(cell).startswith("("):
        return cell
    return re.sub(r'(<w:t(?: [^>]*)?>)([^<]*? \([^<]*)(</w:t>)', split, cell, count=1)


def column_widths(tbl):
    # Two widths per column. The full width puts every body cell and every header name on
    # one line. The least width lets a header name wrap at its spaces, but never its unit.
    full, least = [], []
    for ri, r in enumerate(re.findall(r"<w:tr[ >].*?</w:tr>", tbl, flags=re.S)):
        for ci, c in enumerate(re.findall(r"<w:tc>.*?</w:tc>", r, flags=re.S)):
            if ri == 0:
                parts = [text(p) for p in c.split("<w:br/>")]
                f = max(twips(p, True) for p in parts)
                words = max((twips(w, True) for w in parts[0].split()), default=0)
                m = max([words] + [twips(p, True) for p in parts[1:]])
            else:
                f = m = twips(text(c), False) * 1.04
            full += [0] * (ci + 1 - len(full))
            least += [0] * (ci + 1 - len(least))
            full[ci] = max(full[ci], f + PAD)
            least[ci] = max(least[ci], m + PAD)
    return full, least


def fix_table(tbl):
    if 'w:firstRow="1"' not in tbl:          # the outer frame Quarto puts a caption in
        return tbl, 0
    rows = re.split(r'(?=<w:tr[ >])', tbl)
    out = [rows[0]]
    first = True
    for r in rows[1:]:
        if r.startswith("<w:tr"):
            header = first or "<w:tblHeader" in r.split("</w:trPr>")[0]
            r = fix_row(r, header)
            if header:
                r = re.sub(r"<w:tc>.*?</w:tc>", lambda m: break_unit(m.group(0)), r, flags=re.S)
            first = False
        out.append(r)
    tbl = "".join(out)
    full, least = column_widths(tbl)
    need = sum(full)
    if need <= ROOM_L:
        tw = full
    elif sum(least) <= ROOM_L:
        spare = ROOM_L - sum(least)
        extra = [f - m for f, m in zip(full, least)]
        tw = [m + spare * x / sum(extra) for m, x in zip(least, extra)]
    else:
        tw = [m * ROOM_L / sum(least) for m in least]
    tbl = re.sub(r"<w:tblW [^>]*/>", '<w:tblW w:w="0" w:type="auto"/>', tbl, count=1)
    if "<w:tblLayout" in tbl:
        tbl = re.sub(r'<w:tblLayout [^>]*/>', '<w:tblLayout w:type="autofit"/>', tbl, count=1)
    grid = "<w:tblGrid>" + "".join('<w:gridCol w:w="%d"/>' % round(w) for w in tw) + "</w:tblGrid>"
    tbl = re.sub(r"<w:tblGrid>.*?</w:tblGrid>", grid, tbl, count=1, flags=re.S)
    tbl = re.sub(r'<w:tcW [^>]*/>', '<w:tcW w:w="0" w:type="auto"/>', tbl)
    return tbl, round(need)


def body_elements(d):
    # Top-level paragraphs and tables of the body, as (kind, start, end), tables matched by depth.
    pos = d.index("<w:body>") + len("<w:body>")
    send = d.rindex("<w:sectPr")
    els = []
    while pos < send:
        if d.startswith("<w:tbl>", pos):
            depth, j = 0, pos
            while True:
                a, b = d.find("<w:tbl>", j), d.find("</w:tbl>", j)
                if a != -1 and a < b:
                    depth, j = depth + 1, a + 7
                else:
                    depth, j = depth - 1, b + 8
                    if depth == 0:
                        break
            els.append(("tbl", pos, j))
            pos = j
        elif d.startswith("<w:p>", pos) or d.startswith("<w:p ", pos) or d.startswith("<w:p/>", pos):
            gt = d.index(">", pos)
            j = gt + 1 if d[gt - 1] == "/" else d.index("</w:p>", pos) + 6
            els.append(("p", pos, j))
            pos = j
        elif d.startswith("<w:", pos):
            gt = d.index(">", pos)
            if d[gt - 1] == "/":
                j = gt + 1
            else:
                name = re.match(r"<(w:\w+)", d[pos:]).group(1)
                j = d.index("</%s>" % name, pos) + len(name) + 3
            els.append(("x", pos, j))
            pos = j
        else:
            nxt = d.find("<", pos + 1)
            pos = nxt if nxt != -1 else send
    return els, send


def with_sect(p, sect):
    # A section ends at a paragraph that carries the section's properties as the last child
    # of its paragraph properties.
    if re.fullmatch(r"<w:p(?: [^>]*)?/>", p):
        return "<w:p><w:pPr>%s</w:pPr></w:p>" % sect
    if "<w:pPr/>" in p:
        return p.replace("<w:pPr/>", "<w:pPr>%s</w:pPr>" % sect, 1)
    if "</w:pPr>" in p:
        return p.replace("</w:pPr>", sect + "</w:pPr>", 1)
    return re.sub(r"^<w:p(?: [^>]*)?>", lambda m: m.group(0) + "<w:pPr>%s</w:pPr>" % sect, p, count=1)


def landscape_sections(d):
    els, send = body_elements(d)
    seg = lambda k: d[els[k][1]:els[k][2]]
    is_p = lambda k: els[k][0] == "p"
    empty = lambda k: is_p(k) and text(seg(k)).strip() == ""
    filler = lambda k: els[k][0] == "x" or empty(k) or style(seg(k)) in ("SourceCode", "TableCaption")
    wide = [k for k, e in enumerate(els) if e[0] == "tbl"
            and max([int(n) for n in re.findall(r"<!--need:(\d+)-->", seg(k))] or [0]) > ROOM_P]
    if not wide:
        return d
    blocks = []
    for k in wide:
        s = k - 1 if k > 0 and is_p(k - 1) and style(seg(k - 1)) == "TableCaption" else k
        while s > 0 and is_p(s - 1) and style(seg(s - 1)).startswith("Heading"):
            s -= 1
        if blocks and all(filler(j) for j in range(blocks[-1][1] + 1, s)):
            blocks[-1][1] = k
        else:
            blocks.append([s, k])
    for blk in blocks:                       # notes printed under a table stay with it
        while blk[1] + 1 < len(els) and is_p(blk[1] + 1) and style(seg(blk[1] + 1)) == "SourceCode":
            blk[1] += 1
    sect = d[send:d.index("</w:sectPr>", send) + len("</w:sectPr>")]

    def make(orient, first):
        s = sect if first else re.sub(r"<w:pgNumType[^>]*/>|<w:titlePg\s*/>", "", sect)
        if orient == "landscape":
            s = re.sub(r"<w:pgSz [^>]*/>", '<w:pgSz w:w="16838" w:h="11906" w:orient="landscape"/>', s)
        return s
    tiny = ('<w:p><w:pPr><w:suppressLineNumbers/><w:spacing w:before="0" w:after="0" w:line="20" '
            'w:lineRule="exact"/><w:rPr><w:sz w:val="2"/><w:szCs w:val="2"/></w:rPr>%s</w:pPr></w:p>')
    last = max(k for k, e in enumerate(els) if e[0] != "x")
    tail_landscape = blocks[-1][1] >= last
    edits = []
    for n, (s, e) in enumerate(blocks):
        if s > 0 and is_p(s - 1) and "<w:sectPr" not in seg(s - 1):
            edits.append((els[s - 1][1], els[s - 1][2], with_sect(seg(s - 1), make("portrait", n == 0))))
        else:
            edits.append((els[s][1], els[s][1], tiny % make("portrait", n == 0)))
        if tail_landscape and n == len(blocks) - 1:
            continue
        if empty(e + 1):
            edits.append((els[e + 1][1], els[e + 1][2], with_sect(seg(e + 1), make("landscape", False))))
        else:
            edits.append((els[e][2], els[e][2], tiny % make("landscape", False)))
    for a, b, new in sorted(edits, key=lambda x: (x[0], x[1]), reverse=True):
        d = d[:a] + new + d[b:]
    send = d.rindex("<w:sectPr")
    end = d.index("</w:sectPr>", send) + len("</w:sectPr>")
    return d[:send] + make("landscape" if tail_landscape else "portrait", False) + d[end:]


def title_page_spacing(d):
    blank = '<w:p><w:pPr><w:pStyle w:val="BodyText"/></w:pPr></w:p>'
    paras = [(m.start(), m.end(), m.group(0)) for m in re.finditer(r"<w:p[ >].*?</w:p>", d, flags=re.S)]
    authors = [e for s, e, p in paras if 'w:val="Author"' in p]
    abstract = [e for s, e, p in paras if 'w:val="Abstract"' in p]
    for e in sorted(([authors[-1]] if authors else []) + ([abstract[0]] if abstract else []), reverse=True):
        d = d[:e] + blank + d[e:]
    return d


for path in targets:
    z = zipfile.ZipFile(path)
    items = [(i, z.read(i.filename)) for i in z.infolist()]
    z.close()
    tmp = path + ".tmp"
    with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED) as out:
        for i, data in items:
            if i.filename == "word/document.xml":
                d = data.decode("utf-8")
                # Innermost tables only, each tagged with the width its columns need.
                def one(m):
                    tbl, need = fix_table(m.group(0))
                    return tbl.replace("<w:tbl>", "<w:tbl><!--need:%d-->" % need, 1) if need else tbl
                d = re.sub(r'<w:tbl>(?:(?!<w:tbl>).)*?</w:tbl>', one, d, flags=re.S)
                d = landscape_sections(d)
                d = re.sub(r"<!--need:\d+-->", "", d)
                d = title_page_spacing(d)
                data = d.encode("utf-8")
            out.writestr(i, data)
    shutil.move(tmp, path)
    print("finish-docx: tables, landscape sections and title page spacing set in", path)
