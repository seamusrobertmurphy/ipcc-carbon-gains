"""Post-render step for the Word file, run by Quarto after every render (see
01.manuscript/_quarto.yml). Applies the table formatting that a Word style cannot carry
once Quarto has written its own alignment into each cell: body rows 0.7 cm high with text
left aligned, header rows 0.9 cm high with text centred. Font size and bold come from the
Catena reference document. Nothing else in the file is touched.
"""
import os, re, sys, zipfile, shutil

outputs = os.environ.get("QUARTO_PROJECT_OUTPUT_FILES", "")
targets = [f for f in outputs.split("\n") if f.endswith(".docx")]
if not targets and os.path.exists("Manuscript.docx"):
    targets = ["Manuscript.docx"]

CM = 567                      # twips per centimetre
BODY, HEAD = int(0.7 * CM), int(0.9 * CM)

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
    row = re.sub(r'<w:jc w:val="[a-z]+" />', '', row)
    row = re.sub(r'<w:jc w:val="[a-z]+"/>', '', row)
    row = row.replace("<w:pPr>", '<w:pPr><w:jc w:val="%s" />' % jc)
    return row

def fix_table(tbl):
    if 'w:firstRow="1"' not in tbl:            # the outer wrapper pandoc puts a caption in
        return tbl
    rows = re.split(r'(?=<w:tr[ >])', tbl)
    out = [rows[0]]; first = True
    for r in rows[1:]:
        if r.startswith("<w:tr"):
            header = first or "<w:tblHeader" in r.split("</w:trPr>")[0]
            r = fix_row(r, header); first = False
        out.append(r)
    return "".join(out)

for path in targets:
    z = zipfile.ZipFile(path); items = [(i, z.read(i.filename)) for i in z.infolist()]; z.close()
    tmp = path + ".tmp"
    with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED) as out:
        for i, data in items:
            if i.filename == "word/document.xml":
                d = data.decode("utf-8")
                # innermost tables only: split on inner <w:tbl> blocks that contain no nested table
                d = re.sub(r'<w:tbl>(?:(?!<w:tbl>).)*?</w:tbl>', lambda m: fix_table(m.group(0)), d, flags=re.S)
                data = d.encode("utf-8")
            out.writestr(i, data)
    shutil.move(tmp, path)
    print("finish-docx: table rows set in", path)
