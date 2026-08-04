# make-maps.R
#
# Two figures for the manuscript. Run from the repository root:
#   /usr/local/bin/R --no-save -q -f 05.scripts/make-maps.R
#
# Unlike the manuscript, which is base R so that it renders anywhere, these maps need
# geospatial packages. That is why they live in a saved script rather than in a chunk:
# the figures are committed, the code that made them is committed, and nothing in the
# document depends on sf or terra being installed.
#
#   Figure 1  The global soil estate the Tier 1 pathways apply to, from the 5 arc-minute
#             IPCC soil classification raster (HWSD-derived). Organic soils carry the
#             flux-based Chapter 2 and 3 methods; wetland mineral soils carry the
#             Chapter 5 stock-change method. Country borders are Natural Earth.
#
#   Figure 2  Irish saltmarsh against the salinity gate of Table 4.14. Geometry and the
#             classification are obtained by sourcing prep-irish-saltmarsh-salinity.R,
#             so the map and the manuscript's hectares come from one classification.

suppressMessages({library(sf); library(terra); library(rnaturalearth)})
sf::sf_use_s2(FALSE)

OUT <- "03.outputs/figures"
dir.create(OUT, recursive = TRUE, showWarnings = FALSE)
PAL <- c(org = "#7B3294", wet = "#2C6E49", mineral = "#E8E4DC",
         land = "#F7F5F1", border = "#9A9A9A", sea = "#FFFFFF")

# ---------------------------------------------------------------- Figure 1: global
message("Figure 1: global soil estate")
r <- terra::rast("02.inputs/IPCC/Soil Type (IPCC 2019)/soil_type.tif")

# Raster codes, from 05.scripts/prep-global-area-weights.py:
#   1 Organic, 2 SAN, 3 WET, 4 VOL, 5 POD, 6 HAC, 7 LAC, 8 Other
# Everything that is not organic or wetland mineral is collapsed to a single background
# class, because the figure is about which method applies, not about soil taxonomy.
rc <- terra::classify(r, rbind(c(0, 0, NA), c(1, 1, 1), c(2, 2, 3), c(3, 3, 2),
                               c(4, 8, 3)), include.lowest = TRUE)

world <- rnaturalearth::ne_countries(scale = "small", returnclass = "sf")

png(file.path(OUT, "fig-global-pathway-estate.png"), width = 2400, height = 1250, res = 220)
op <- par(mar = c(0.4, 0.4, 1.8, 0.4), xaxs = "i", yaxs = "i")
plot(terra::ext(-180, 180, -60, 84), type = "n", axes = FALSE, xlab = "", ylab = "",
     asp = 1, main = "")
rect(-180, -60, 180, 84, col = PAL[["sea"]], border = NA)
plot(sf::st_geometry(world), col = PAL[["land"]], border = NA, add = TRUE)
terra::plot(rc, add = TRUE, legend = FALSE, maxcell = 4e6,
            col = c(PAL[["org"]], PAL[["wet"]], PAL[["mineral"]]))
plot(sf::st_geometry(world), col = NA, border = PAL[["border"]], lwd = 0.25, add = TRUE)
title(main = "Soil classes carrying the Tier 1 gain pathways", adj = 0, cex.main = 1.0,
      font.main = 1, line = 0.4)
legend("bottomleft", bty = "n", cex = 0.72, pch = 15, pt.cex = 1.5,
       col = c(PAL[["org"]], PAL[["wet"]], PAL[["mineral"]]),
       legend = c("Organic soils: flux-based method, Wetlands Supplement Ch.2 and Ch.3",
                  "Wetland mineral soils: stock-change method, Ch.5",
                  "Other mineral soils: stock-change method, 2019 Refinement Ch.2"))
par(op); invisible(dev.off())

# ---------------------------------------------------------------- Figure 2: Ireland
message("Figure 2: Irish saltmarsh and the 18 ppt gate")

# Source the prep script in its own environment so the map inherits its classification
# rather than reimplementing it. The script prints its own summary; that is left visible.
# The prep script resolves its inputs relative to 05.scripts/, so source it from there.
env <- new.env()
old_wd <- setwd("05.scripts")
sys.source("prep-irish-saltmarsh-salinity.R", envir = env)
setwd(old_wd)
sm  <- get("sm",  envir = env)
twb <- get("twb", envir = env)

irl <- rnaturalearth::ne_countries(scale = "large", returnclass = "sf",
                                   country = c("Ireland", "United Kingdom"))
irl <- sf::st_transform(irl, sf::st_crs(sm))
twb <- sf::st_transform(twb, sf::st_crs(sm))

ann <- sm[sm$stratum == "Annex I saltmarsh, confirmed", ]
cls <- c("Below 18 ppt throughout" = "#A4303F", "Spans 18 ppt" = "#E9C46A",
         "Above 18 ppt throughout" = "#2C6E49", "Not surveyed" = "#6C6C6C",
         "Outside any transitional water body" = "#BFBFBF")
ann$col <- cls[ann$salinity_class]

# Frame on the island of Ireland. The United Kingdom polygon is still drawn, because the
# border with Northern Ireland is the northern limit of the dataset and should be visible.
bb <- sf::st_bbox(irl[irl$admin == "Ireland", ])
pad <- 0.06 * max(bb["xmax"] - bb["xmin"], bb["ymax"] - bb["ymin"])
bb <- bb + c(-pad, -pad, pad, pad)
png(file.path(OUT, "fig-ireland-saltmarsh-salinity.png"), width = 1700, height = 2000, res = 220)
op <- par(mar = c(0.4, 0.4, 1.8, 0.4))
plot(sf::st_geometry(irl), col = PAL[["land"]], border = PAL[["border"]], lwd = 0.6,
     xlim = bb[c("xmin", "xmax")], ylim = bb[c("ymin", "ymax")])
plot(sf::st_geometry(twb), col = "#D9E4EC", border = "#9FB6C4", lwd = 0.3, add = TRUE)
# Saltmarsh polygons are small at national scale, so they are drawn as weighted points
# at their centroids. Area is preserved in the symbol size, not in the outline.
ctr <- suppressWarnings(sf::st_centroid(sf::st_geometry(ann)))
xy  <- sf::st_coordinates(ctr)
points(xy, pch = 21, bg = ann$col, col = "#333333", lwd = 0.25,
       cex = 0.35 + 1.5 * sqrt(ann$area_ha / max(ann$area_ha)))
title(main = "Irish Annex I saltmarsh by the salinity regime of its water body",
      adj = 0, cex.main = 0.95, font.main = 1, line = 0.4)
legend("topright", bty = "n", cex = 0.66, pch = 21, pt.cex = 1.2, pt.lwd = 0.25,
       pt.bg = cls, col = "#333333", legend = names(cls))
legend("bottomright", bty = "n", cex = 0.62, fill = "#D9E4EC", border = "#9FB6C4",
       legend = "WFD transitional water bodies")
par(op); invisible(dev.off())

message("wrote:")
for (f in list.files(OUT, pattern = "^fig-(global|ireland)", full.names = TRUE))
  message(sprintf("  %s  %.0f kB", f, file.size(f) / 1024))
