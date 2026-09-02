"""Assemble the five Irish input maps into one A4 portrait panel for the manuscript.

Reads the PNGs written by make-input-maps.R and prep-irish-saltmarsh-salinity.R from
03.outputs/figures/ and writes fig-ireland-panel.png at 450 dpi (3720 x 5262 px), which
clears Elsevier's 3740-pixel full-page width for combination artwork within rounding.
Panels are lettered A to E; the source figures keep their own (a) and (b) sub-panels.
"""
from PIL import Image, ImageDraw, ImageFont
import os

FIG = os.path.join(os.path.dirname(__file__), "..", "03.outputs", "figures")
DPI = 450
W, H = int(8.27 * DPI), int(11.69 * DPI)          # A4 portrait
M = int(0.15 * DPI)                                # outer margin
G = int(0.15 * DPI)                                # gutter

panels = [
    ("A", "fig-ireland-ipcc-defaults.png"),
    ("B", "fig-ireland-organic-soil.png"),
    ("C", "fig-ireland-saltmarsh-salinity.png"),
    ("D", "fig-ireland-saltmarsh-coverage.png"),
    ("E", "fig-ireland-sis-soils.png"),
]

canvas = Image.new("RGB", (W, H), "white")
draw = ImageDraw.Draw(canvas)
try:
    font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", int(0.32 * DPI))
except OSError:
    font = ImageFont.load_default()

cell_w = (W - 2 * M - G) // 2
cell_h = (H - 2 * M - 2 * G) // 3

def place(letter, fname, col, row, span=1):
    im = Image.open(os.path.join(FIG, fname)).convert("RGB")
    box_w = cell_w * span + G * (span - 1)
    scale = min(box_w / im.width, cell_h / im.height)
    im = im.resize((int(im.width * scale), int(im.height * scale)), Image.LANCZOS)
    x0 = M + col * (cell_w + G) + (box_w - im.width) // 2
    y0 = M + row * (cell_h + G) + (cell_h - im.height) // 2
    canvas.paste(im, (x0, y0))
    draw.text((x0 + int(0.05 * DPI), y0 + int(0.02 * DPI)), letter, fill="black", font=font)

place("A", panels[0][1], 0, 0)
place("B", panels[1][1], 1, 0)
place("C", panels[2][1], 0, 1)
place("D", panels[3][1], 1, 1)
place("E", panels[4][1], 0, 2, span=2)

out = os.path.join(FIG, "fig-ireland-panel.png")
canvas.save(out, dpi=(DPI, DPI))
print(out, canvas.size)
