# make-input-maps.R
#
# Verification maps of the spatial inputs. Run from the repository root:
#   /usr/local/bin/R --no-save -q -f 05.scripts/make-input-maps.R
#
# WHY THIS EXISTS
# ---------------
# make-maps.R draws the two figures the manuscript prints. This script draws the layers
# themselves, so that what the analysis reads can be seen against a national border rather
# than trusted from a row count. Every panel carries the border of the Republic of Ireland
# and the Northern Ireland boundary, because three of the four Irish datasets stop at that
# line and a reader must be able to tell missing data from absent habitat.
#
# Like make-maps.R this needs sf and terra, which is why it is a saved script and not a
# manuscript chunk: the figures are committed, the code that made them is committed, and
# the document still renders on base R alone.
#
#   Figure 1  Irish Soil Information System: soil groups, and the soil organic carbon
#             values attached to them. The paper's structural claim, that the national map
#             carries no carbon stock for peat, is a thing you can see.
#   Figure 2  The two global IPCC layers that key the Tier 1 defaults, clipped to Ireland:
#             the 5 arc-minute soil classification and the FAO ecological zone.
#   Figure 3  Organic soil as the global default raster has it against the national map,
#             at the same scale, with both areas computed.
#   Figure 4  The saltmarsh resource in full, and the transitional water bodies behind the
#             salinity gate, showing how little of the network was ever surveyed.
#
# NOT MAPPED, deliberately: 02.inputs/IPCC/Wetlands (GLWD 2023)/. That layer holds lakes,
# reservoirs and rivers and contains no wetland class at all; see its README. Drawing it
# under the folder's name would assert something the data does not say.
#
# Every area this script prints is also written to
# 02.inputs/derived/irish-input-map-checks.csv, so no figure quoted from these maps comes
# from code that was not saved.
#
# LAYOUT RULE: no legend is ever drawn over the map. Each figure is laid out with
# layout(), one cell per panel and a dedicated cell beneath it for that panel's legend, so
# a legend can neither cover a coastline nor be clipped by the plot region.
#
# TWO DEFECTS IN THE SALINITY JOIN, both found by drawing Figure 4 on 2026-08-04:
#   1. FIXED. prep-irish-saltmarsh-salinity.R matched the pattern "Kinvara" against a layer
#      that spells it "Kinvarra Bay", so the record was dropped in silence and 12.7 ha of
#      confirmed Annex I saltmarsh was filed as "Not surveyed". The pattern now accepts
#      either spelling and exposure moves from 225.1 ha (9.9%) to 237.8 ha (10.5%).
#   2. NOT FIXABLE. "Tralee Bay" appears nowhere in the transitional water body layer; it is
#      a coastal water body, not a transitional one. It is the only system IFI recorded
#      above 18 ppt throughout (37.4 to 41.2 ppt), so the absence of any hectare above the
#      threshold is a property of the layer, not of the marshes. The manuscript says so.
# Nine of the 195 water bodies therefore carry a salinity, from eight of the nine systems
# IFI measured; Ballysadare spans two of the layer's polygons.

suppressMessages({library(sf); library(terra); library(rnaturalearth)})
sf::sf_use_s2(FALSE)
source("05.scripts/map-furniture.R")   # map_graticule() and map_furniture()

OUT <- "03.outputs/figures"
DERIVED <- "02.inputs/derived"
dir.create(OUT, recursive = TRUE, showWarnings = FALSE)

SIS_PATH <- "02.inputs/IRL/SIS/SOIL_SISNationalSoils.shp"
TIF_PATH <- "02.inputs/IPCC/Soil Type (IPCC 2019)/soil_type.tif"
GEZ_PATH <- "02.inputs/IPCC/Veg Type (IPCC 2019)/gez_2010_wgs84.shp"
stopifnot(file.exists(SIS_PATH), file.exists(TIF_PATH), file.exists(GEZ_PATH))

EPSG <- 2157        # Irish Transverse Mercator, metres
PAL  <- c(land = "#F7F5F1", border = "#6E6E6E", sea = "#FFFFFF", blank = "#C9C6C0")

# Rows accumulate here and are written out at the end.
checks <- list()
note <- function(layer, class, area_ha, n, comment = "") {
  checks[[length(checks) + 1L]] <<- data.frame(
    layer = layer, class = class, area_ha = round(area_ha, 1),
    n_features = n, note = comment, stringsAsFactors = FALSE)
}

# ------------------------------------------------------------------ national borders
message("Natural Earth borders ...")
bord <- rnaturalearth::ne_countries(scale = "large", returnclass = "sf",
                                    country = c("Ireland", "United Kingdom"))
bord <- sf::st_transform(bord, EPSG)
roi  <- bord[bord$admin == "Ireland", ]     # the Republic: the extent of every Irish dataset
uk   <- bord[bord$admin == "United Kingdom", ]

# Frame on the island, with room for the Northern Ireland boundary at the top.
bb <- sf::st_bbox(roi)
pad <- 0.05 * max(bb["xmax"] - bb["xmin"], bb["ymax"] - bb["ymin"])
XLIM <- c(bb[["xmin"]] - pad, bb[["xmax"]] + pad)
YLIM <- c(bb[["ymin"]] - pad, bb[["ymax"]] + 2.2 * pad)

# Two map panels over two legend cells. The legend strip is a plot region of its own, so
# nothing can be drawn over the map and nothing can be clipped by it.
open_figure <- function(file, height = 1700, legend_share = 0.20) {
  png(file, width = 2300, height = height, res = 220)
  layout(matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE),
         heights = c(1, legend_share))
}
map_panel <- function(main) {
  # Left and bottom margins carry the graticule labels, so no degree label is drawn over
  # the map itself.
  par(mar = c(1.5, 2.0, 1.5, 0.4))
  plot(sf::st_geometry(roi), col = PAL[["land"]], border = NA,
       xlim = XLIM, ylim = YLIM, main = "")
  plot(sf::st_geometry(uk), col = "#EDEBE7", border = NA, add = TRUE)
  title(main = main, adj = 0, cex.main = 0.82, font.main = 1, line = 0.25)
}

# Border, graticule and furniture are drawn last on every panel, so no data hides them.
frame_border <- function() {
  plot(sf::st_geometry(uk), col = NA, border = PAL[["border"]], lwd = 0.5, add = TRUE)
  plot(sf::st_geometry(roi), col = NA, border = PAL[["border"]], lwd = 0.9, add = TRUE)
  map_graticule(EPSG, lon = seq(-11, -5, by = 1), lat = seq(51, 56, by = 1))
  map_furniture("EPSG:2157, Irish Transverse Mercator")
}
legend_cell <- function(...) {
  par(mar = c(0.2, 1.0, 0.2, 0.2))
  plot.new()
  legend("topleft", bty = "n", ...)
}

# ------------------------------------------------------- Figure 1: the national soils map
message("Figure 1: Irish Soil Information System")
sis <- sf::st_read(SIS_PATH, quiet = TRUE)
sis <- sf::st_transform(sis, EPSG)

# Field names differ between the WFS export and the older ArcGIS one; accept either.
pick <- function(d, ...) { for (n in c(...)) if (n %in% names(d)) return(d[[n]]); NULL }
sis$tex <- pick(sis, "Texture", "TEXTURE")
sis$soc <- as.numeric(pick(sis, "SOC"))
tex <- ifelse(is.na(sis$tex), "(none)", sis$tex)

# Four groups. The split that matters is inside peat: the map's SOC column is populated on
# the shallow peat associations over rock and blank on the blanket and raised bog.
sis$grp <- ifelse(tex == "Peat" & is.na(sis$soc), "Peat, no carbon stock in the map",
           ifelse(tex == "Peat" & !is.na(sis$soc), "Peat texture, carbon stock present",
           ifelse(!is.na(sis$soc), "Mineral soil, carbon stock present",
                  "Not a soil unit: rock, water, urban, dune")))
GRP <- c("Peat, no carbon stock in the map"    = "#7B3294",
         "Peat texture, carbon stock present"  = "#C2A5CF",
         "Mineral soil, carbon stock present"  = "#A6BDDB",
         "Not a soil unit: rock, water, urban, dune" = PAL[["blank"]])
sis$area_ha <- as.numeric(sf::st_area(sis)) / 10000

for (g in names(GRP))
  note("SIS national soils map", g, sum(sis$area_ha[sis$grp == g]), sum(sis$grp == g))
note("SIS national soils map", "ALL polygons", sum(sis$area_ha), nrow(sis),
     "cross-check against the map's own Ha column")

# Panel (b) shades the SOC value itself. Breaks are fixed, not quantile, so the classes
# mean the same thing if the map is ever revised.
brk <- c(100, 125, 150, 175, 200, 250, 320)
SOCPAL <- c("#EDF8E9", "#C7E9C0", "#A1D99B", "#74C476", "#31A354", "#006D2C")
sis$soc_bin <- cut(sis$soc, breaks = brk, include.lowest = TRUE)

open_figure(file.path(OUT, "fig-ireland-sis-soils.png"))

map_panel("(a) Soil groups, Irish Soil Information System")
plot(sf::st_geometry(sis), col = GRP[sis$grp], border = NA, add = TRUE)
frame_border()

map_panel("(b) Soil organic carbon attached to those units")
plot(sf::st_geometry(sis), col = PAL[["blank"]], border = NA, add = TRUE)
has <- !is.na(sis$soc)
plot(sf::st_geometry(sis)[has], col = SOCPAL[as.integer(sis$soc_bin[has])],
     border = NA, add = TRUE)
frame_border()

legend_cell(cex = 0.58, pch = 15, pt.cex = 1.4, y.intersp = 1.15,
            col = GRP, legend = names(GRP))
legend_cell(cex = 0.58, pch = 15, pt.cex = 1.4, y.intersp = 1.15, ncol = 2,
            col = c(SOCPAL, PAL[["blank"]]),
            legend = c("100-125 t C/ha", "125-150", "150-175", "175-200",
                       "200-250", "250-320", "No value in the map"))
invisible(dev.off())

# ------------------------------------------- Figure 2: the global IPCC layers over Ireland
message("Figure 2: IPCC default strata over Ireland")
roi_wgs <- sf::st_transform(roi, 4326)
box_wgs <- sf::st_as_sfc(sf::st_bbox(c(xmin = -11.2, ymin = 51.2, xmax = -5.2, ymax = 55.6),
                                     crs = 4326))

r  <- terra::rast(TIF_PATH)
ri <- terra::crop(r, terra::ext(-11.2, -5.2, 51.2, 55.6))
ri <- terra::mask(ri, terra::vect(roi_wgs))
ri[ri == 0] <- NA
# Legend from the Idrisi sidecar SOIL_TYPE.RDC, as encoded in prep-global-area-weights.py.
SOILNAME <- c("Organic", "Sandy", "Wetland", "Volcanic", "Spodic",
              "High activity clay", "Low activity clay", "Other")
SOILCOL  <- c("#7B3294", "#F2E394", "#2C6E49", "#B2456E", "#7FB3D5",
              "#D8B365", "#F6E8C3", "#BFBFBF")
csz <- terra::cellSize(ri, unit = "ha")
zs  <- terra::zonal(csz, ri, fun = "sum", na.rm = TRUE)
names(zs) <- c("code", "area_ha")
for (k in seq_len(nrow(zs)))
  note("IPCC 5 arc-minute soil raster, clipped to the Republic",
       SOILNAME[zs$code[k]], zs$area_ha[k], NA_integer_,
       "cell area, EPSG:4326 grid, masked to the Natural Earth border")

gez <- sf::st_read(GEZ_PATH, quiet = TRUE)
gez <- sf::st_make_valid(gez)
gez <- suppressWarnings(sf::st_crop(gez, sf::st_bbox(box_wgs)))
gez <- suppressWarnings(sf::st_intersection(gez, roi_wgs["admin"]))
gez <- sf::st_transform(gez, EPSG)
gez$area_ha <- as.numeric(sf::st_area(gez)) / 10000
gz <- aggregate(area_ha ~ gez_name, data = sf::st_drop_geometry(gez), FUN = sum)
gz <- gz[order(-gz$area_ha), ]
for (k in seq_len(nrow(gz)))
  note("FAO Global Ecological Zones 2010, clipped to the Republic",
       gz$gez_name[k], gz$area_ha[k], sum(gez$gez_name == gz$gez_name[k]),
       "the crosswalk to the IPCC climate zone is an approximation")
GEZCOL <- setNames(c("#4A7C59", "#9BC1BC", "#E0A458", "#B5B682")[seq_len(nrow(gz))],
                   gz$gez_name)

open_figure(file.path(OUT, "fig-ireland-ipcc-defaults.png"))
present <- sort(unique(zs$code))

map_panel("(a) IPCC soil class, 5 arc-minute global raster")
terra::plot(terra::project(ri, paste0("EPSG:", EPSG), method = "near"),
            add = TRUE, legend = FALSE, col = data.frame(value = 1:8, col = SOILCOL))
frame_border()

map_panel("(b) FAO ecological zone, the climate stratification")
plot(sf::st_geometry(gez), col = GEZCOL[gez$gez_name], border = NA, add = TRUE)
frame_border()

legend_cell(cex = 0.58, pch = 15, pt.cex = 1.4, y.intersp = 1.15, ncol = 2,
            col = SOILCOL[present], legend = SOILNAME[present])
legend_cell(cex = 0.58, pch = 15, pt.cex = 1.4, y.intersp = 1.15,
            col = GEZCOL, legend = names(GEZCOL))
invisible(dev.off())

# ------------------------------------------ Figure 3: default organic soil against the map
message("Figure 3: default organic soil against the national map")
org <- ri; org[org != 1] <- NA
org_ha <- sum(terra::values(terra::cellSize(org, unit = "ha") * (org == 1)), na.rm = TRUE)
peat <- sis[sis$grp %in% c("Peat, no carbon stock in the map",
                           "Peat texture, carbon stock present"), ]
peat_ha <- sum(peat$area_ha)
note("Organic soil comparison", "IPCC raster, class Organic", org_ha, NA_integer_,
     "5 arc-minute cells whose modal class is organic")
note("Organic soil comparison", "SIS, all peat-texture polygons", peat_ha, nrow(peat),
     "national map, 1:250,000 polygons")

open_figure(file.path(OUT, "fig-ireland-organic-soil.png"), legend_share = 0.14)

map_panel(sprintf("(a) Organic soil, IPCC global default: %.2f Mha", org_ha / 1e6))
terra::plot(terra::project(org, paste0("EPSG:", EPSG), method = "near"),
            add = TRUE, legend = FALSE, col = "#7B3294")
frame_border()

map_panel(sprintf("(b) Peat, Irish Soil Information System: %.2f Mha", peat_ha / 1e6))
plot(sf::st_geometry(peat), col = "#7B3294", border = NA, add = TRUE)
frame_border()

legend_cell(cex = 0.58, pch = 15, pt.cex = 1.4, col = "#7B3294",
            legend = "Class 1, Organic. 5 arc-minute cells, roughly 50 sq km each")
legend_cell(cex = 0.58, pch = 15, pt.cex = 1.4, col = "#7B3294",
            legend = "Peat-texture associations, national map at 1:250,000")
invisible(dev.off())

rm(sis, peat, r, ri, org); invisible(gc())

# ------------------------------------------------------- Figure 4: saltmarsh and the gate
message("Figure 4: saltmarsh resource and the salinity survey coverage")

# Source the prep script in its own environment, exactly as make-maps.R does, so the map
# and the manuscript's hectares come from one classification and cannot drift.
env <- new.env()
old_wd <- setwd("05.scripts")
sys.source("prep-irish-saltmarsh-salinity.R", envir = env)
setwd(old_wd)
sm  <- sf::st_transform(get("sm",  envir = env), EPSG)
twb <- sf::st_transform(get("twb", envir = env), EPSG)
ifi <- get("ifi", envir = env)

# Mark which water bodies Inland Fisheries Ireland actually measured, using the same
# patterns the classification uses.
twb$surveyed <- Reduce(`|`, lapply(ifi$pattern, function(p) grepl(p, twb$Name)))
twb$area_ha <- as.numeric(sf::st_area(twb)) / 10000
note("EPA WFD transitional water bodies", "Salinity measured",
     sum(twb$area_ha[twb$surveyed]), sum(twb$surveyed), "eight of the nine IFI systems")
note("EPA WFD transitional water bodies", "No salinity measurement",
     sum(twb$area_ha[!twb$surveyed]), sum(!twb$surveyed), "")

# One marker per IFI system, so the measurements are legible at national scale and the one
# that cannot reach the classification can be seen rather than described.
ifi$class <- with(ifi, ifelse(sal_max < 18, "below 18 throughout",
                       ifelse(sal_min >= 18, "above 18 throughout", "spans 18")))
ifi$x <- NA_real_; ifi$y <- NA_real_; ifi$label <- NA_character_
for (k in seq_len(nrow(ifi))) {
  h <- grep(ifi$pattern[k], twb$Name)
  if (!length(h)) next
  ctr_k <- suppressWarnings(sf::st_centroid(sf::st_union(sf::st_geometry(twb)[h])))
  ifi$x[k] <- sf::st_coordinates(ctr_k)[1]
  ifi$y[k] <- sf::st_coordinates(ctr_k)[2]
  ifi$label[k] <- if (length(h) == 1L) twb$Name[h]
                  else sprintf("%s and %d more", twb$Name[h[1]], length(h) - 1L)
}
ifi$in_layer <- !is.na(ifi$x)
ifi <- ifi[order(-ifi$in_layer, ifi$label), ]
ifi$id <- ifelse(ifi$in_layer, seq_len(nrow(ifi)), NA_integer_)
for (k in which(ifi$in_layer))
  note("Inland Fisheries Ireland 2015 salinity", ifi$label[k], NA_real_, NA_integer_,
       sprintf("%.3f to %.3f ppt, %s", ifi$sal_min[k], ifi$sal_max[k], ifi$class[k]))
for (k in which(!ifi$in_layer))
  note("Inland Fisheries Ireland 2015 salinity", sub("^\\^|\\$$", "", ifi$pattern[k]),
       NA_real_, NA_integer_,
       sprintf("%.3f to %.3f ppt, %s, absent from the transitional water body layer",
               ifi$sal_min[k], ifi$sal_max[k], ifi$class[k]))

sm$area_ha <- as.numeric(sf::st_area(sm)) / 10000
STR <- c("Annex I saltmarsh, confirmed"      = "#A4303F",
         "Annex I saltmarsh, potential"      = "#E9C46A",
         "Spartina sward"                    = "#2C6E49",
         "Other, non-Annex"                  = "#7FB3D5",
         "Mudflat/sandflat (not saltmarsh)"  = PAL[["blank"]])
for (s in names(STR))
  note("NPWS Saltmarsh Monitoring Project", s, sum(sm$area_ha[sm$stratum == s]),
       sum(sm$stratum == s),
       if (s == "Mudflat/sandflat (not saltmarsh)") "excluded from every saltmarsh total"
       else "")

ctr <- suppressWarnings(sf::st_centroid(sf::st_geometry(sm)))
xy  <- sf::st_coordinates(ctr)
sz  <- 0.3 + 1.4 * sqrt(sm$area_ha / max(sm$area_ha))

open_figure(file.path(OUT, "fig-ireland-saltmarsh-coverage.png"), legend_share = 0.30)

map_panel("(a) The saltmarsh resource, all strata")
plot(sf::st_geometry(roi), col = NA, border = PAL[["border"]], lwd = 0.9, add = TRUE)
ord <- order(-sm$area_ha)   # small polygons drawn last so they are not buried
points(xy[ord, , drop = FALSE], pch = 21, bg = STR[sm$stratum[ord]],
       col = "#333333", lwd = 0.2, cex = sz[ord])
frame_border()

map_panel(sprintf("(b) The %d transitional water bodies, and the salinity measurements",
                  nrow(twb)))
plot(sf::st_geometry(twb), col = "#7FA8C4", border = "#5C86A2", lwd = 0.5, add = TRUE)
frame_border()
# Markers last, so no graticule line crosses a number and makes it unreadable.
mk <- ifi[ifi$in_layer, ]
points(mk$x, mk$y, pch = 21, cex = 2.3, lwd = 0.6, col = "#333333", bg = "#E9C46A")
text(mk$x, mk$y, labels = mk$id, cex = 0.46, font = 2, col = "#333333")

legend_cell(cex = 0.58, pch = 21, pt.cex = 1.2, pt.lwd = 0.2, y.intersp = 1.15,
            pt.bg = STR, col = "#333333", legend = names(STR))

# The key is written out in full here rather than annotated on the map, so no label can
# collide with another label or with a coastline.
key <- c(sprintf("%d  %s, %.2g to %.2g ppt, %s", mk$id, mk$label,
                 mk$sal_min, mk$sal_max, mk$class),
         "",
         sprintf("%s is the ninth system Inland Fisheries Ireland measured and the",
                 sub("^\\^|\\$$", "", ifi$pattern[!ifi$in_layer][1])),
         "only one recorded above 18 ppt throughout, but it is a coastal rather",
         "than a transitional water body and is absent from this layer.",
         sprintf("The remaining %d water bodies carry no measurement at all.",
                 nrow(twb) - sum(twb$surveyed)))
legend_cell(cex = 0.5, y.intersp = 1.1, legend = key)
invisible(dev.off())

# ------------------------------------------------------------------------------- outputs
tab <- do.call(rbind, checks)
out <- file.path(DERIVED, "irish-input-map-checks.csv")
write.csv(tab, out, row.names = FALSE)
message("\nWrote: ", out)
print(tab, row.names = FALSE)

message("\nFigures:")
for (f in list.files(OUT, pattern = "^fig-ireland-(sis|ipcc|organic|saltmarsh-coverage)",
                     full.names = TRUE))
  message(sprintf("  %s  %.0f kB", f, file.size(f) / 1024))
