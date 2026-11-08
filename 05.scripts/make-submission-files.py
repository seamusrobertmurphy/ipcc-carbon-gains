"""Build the separate submission files Catena asks for, from the current render.

  01.manuscript/Figures.docx   the main-text figures with their rendered captions
  01.manuscript/Tables.docx    the supplementary tables, carved from Manuscript.docx
  01.manuscript/Cover Letter.docx  from Cover Letter - Murphy 2026 Catena.md
  01.manuscript/Figures/Figure_N   each figure as its own file, for the artwork guide

Run from 01.manuscript/ after `quarto render Manuscript.qmd` (the post-render hook does
this). Captions come from the rendered HTML, so every inline value is already computed.
"""
import html, os, re, shutil, subprocess, zipfile

HERE = os.path.dirname(os.path.abspath(__file__))
MAN = os.path.normpath(os.path.join(HERE, "..", "01.manuscript"))
REF = os.path.normpath(os.path.join(HERE, "..", "04.references", "style-catena.docx"))
os.chdir(MAN)

h = open("Manuscript.html", encoding="utf-8").read()
q = open("Manuscript.qmd", encoding="utf-8").read()

# ---- Figures.docx: main-text figures in order, caption from the render, image from the qmd
labels = re.findall(r'#\| label: (fig-[\w-]+)', q)
paths = {}
for lab in labels:
    blk = q[q.find("#| label: " + lab):]
    m = re.search(r'include_graphics\("([^"]+)"\)', blk[:4000])
    paths[lab] = m.group(1) if m else "../03.outputs/figures/%s-1.png" % lab
caps = {}
for m in re.finditer(r'<figcaption[^>]*id="(fig-[\w-]+)-caption-[^"]*"[^>]*>(.*?)</figcaption>', h, flags=re.S):
    caps[m.group(1)] = re.sub(r'\s+', ' ', html.unescape(re.sub(r'<[^>]+>', '', m.group(2)))).strip()
md = ["# Figures", ""]
for lab in labels:
    if lab in caps and os.path.exists(paths[lab]):
        md += ["![%s](%s)" % (caps[lab], paths[lab]), "", "\\newpage", ""]
open(".figures.md", "w", encoding="utf-8").write("\n".join(md))
subprocess.run(["pandoc", ".figures.md", "--reference-doc", REF, "-o", "Figures.docx"], check=True)
os.remove(".figures.md")
print("Figures.docx:", len([l for l in labels if l in caps]), "figures")

# ---- Tables.docx: everything from the Supplementary material heading to the end of the body
z = zipfile.ZipFile("Manuscript.docx"); items = [(i, z.read(i.filename)) for i in z.infolist()]; z.close()
doc = dict((i.filename, d) for i, d in items)["word/document.xml"].decode("utf-8")
body_start = doc.index("<w:body>") + len("<w:body>")
sect = doc.rfind("<w:sectPr")
body = doc[body_start:sect]
k = body.find("Supplementary material")
k = max(m.start() for m in re.finditer(r"<w:p[ >]", body[:k]))
supp = body[k:]
new = doc[:body_start] + supp + doc[sect:]
with zipfile.ZipFile("Tables.docx", "w", zipfile.ZIP_DEFLATED) as out:
    for i, data in items:
        out.writestr(i, new.encode("utf-8") if i.filename == "word/document.xml" else data)
print("Tables.docx:", supp.count("<w:tbl>") - supp.count('w:firstRow="0"'), "tables")

# ---- Cover letter
subprocess.run(["pandoc", "Cover Letter - Murphy 2026 Catena.md", "--reference-doc", REF,
                "-o", "Cover Letter.docx"], check=True)
print("Cover Letter.docx written")

# ---- Declaration of competing interest and highlights: title line kept equal to the manuscript's
title = re.search(r'^title: "(.*)"', q, flags=re.M).group(1)
dec = "Declaration of Competing Interest - Murphy 2026 Catena"
d = open(dec + ".md", encoding="utf-8").read()
d = re.sub(r'^Manuscript title: .*$', "Manuscript title: " + title, d, flags=re.M)
open(dec + ".md", "w", encoding="utf-8").write(d)
subprocess.run(["pandoc", dec + ".md", "-o", dec + ".docx"], check=True)
subprocess.run(["pandoc", "Highlights - Murphy 2026 Catena.md", "-o", "Highlights - Murphy 2026 Catena.docx"], check=True)
print("Declaration and highlights rebuilt with title:", title[:60], "...")

# ---- Separate figure files for upload, named Figure_1, Figure_2 and so on as Catena's
# artwork guide asks, in the order the figures appear. A chart drawn in the manuscript goes
# as its vector PDF with embedded fonts where one exists, and any other figure as PNG. Each
# PNG is tagged with the dpi that prints it at the full page width of 190 mm.
UP = "Figures"
os.makedirs(UP, exist_ok=True)
for f in os.listdir(UP):
    if f.startswith("Figure_"):
        os.remove(os.path.join(UP, f))
for i, lab in enumerate(labels, 1):
    png = paths[lab]
    pdf = re.sub(r"\.png$", ".pdf", png)
    src = pdf if os.path.exists(pdf) else png
    dst = os.path.join(UP, "Figure_%d%s" % (i, os.path.splitext(src)[1]))
    shutil.copyfile(src, dst)
    if dst.endswith(".png"):
        out = subprocess.run(["sips", "-g", "pixelWidth", dst], capture_output=True, text=True).stdout
        dpi = str(round(int(re.search(r"pixelWidth: (\d+)", out).group(1)) / (190 / 25.4)))
        subprocess.run(["sips", "-s", "dpiWidth", dpi, "-s", "dpiHeight", dpi, dst],
                       check=True, capture_output=True)
print("Figure files written:", ", ".join(sorted(os.listdir(UP))))
