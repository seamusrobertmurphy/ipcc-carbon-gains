# prep-irish-soils.R
#
# Stage 1 of the two-stage rule in tasks/Irish-data-sources.md: spatial work happens
# here, outside the render, and writes a small tidy CSV that the manuscript reads with
# base read.csv. The manuscript stays base-R and keeps its "renders anywhere" property.
#
# STATUS 2026-07-31: cannot run yet. The Irish Soil Information System national soils
# layer was delivered without its geometry (.shp) or attributes (.dbf); only the .shx
# index, .prj, .CPG and ArcGIS .lyr symbology arrived. See 02.inputs/MANIFEST.md.
#
# What the surviving sidecars tell us the export must contain, so it can be checked on
# arrival rather than discovered to be wrong later:
#
#   Features : 25,143 polygons. Derived from the .shx index, which is 100 bytes of header
#              plus one 8-byte record per feature; (201244 - 100) / 8 = 25143.
#   CRS      : TM65 Irish Grid, EPSG:29902. Read verbatim from SOIL_SISNationalSoils.prj
#              (PROJCS "TM65_Irish_Grid", Airy Modified spheroid, false easting 200000,
#              false northing 250000, central meridian -8, scale factor 1.000035).
#   Fields   : ten, listed in the delivered README.txt with their aliases. The left-hand
#              names are the shapefile's 10-character truncations.
#
#     Associatio  -> Association_Unit
#     Associat_1  -> Association_Symbol
#     Associat_2  -> Association_Name
#     Texture_Su  -> Texture_Substrate_Type
#     ha          -> ha
#     DRAINAGE    -> DRAINAGE
#     TEXTURE     -> TEXTURE
#     DEPTH       -> DEPTH
#     SOC         -> SOC
#     URL         -> URL
#
# SOC and DRAINAGE are the two the paper needs. SOC is the route to the IPCC soil classes
# that Equation 2.25 is keyed on (HAC, LAC, SAN, POD, VOL, WET), and DRAINAGE is the route
# to the drained-versus-undrained split that decides whether a hectare is scored by
# stock-change or by flux.
#
# PREFER A GEOPACKAGE. A shapefile truncates field names to ten characters, which is why
# three of the ten above are mangled, and it splits one layer across seven files, which is
# how the geometry and attributes came to be lost in the first place.
#
# This script deliberately does NOT yet map soil classes onto IPCC classes. The category
# values of SOC, DRAINAGE, TEXTURE and DEPTH have never been seen, so any mapping written
# now would be a guess. Run this first; it reports the vocabulary. Write the mapping second.

suppressPackageStartupMessages(library(sf))

IN_DIR  <- "../02.inputs/IRL/SIS"
OUT_DIR <- "../02.inputs/derived"
EXPECTED_FEATURES <- 25143L
EXPECTED_EPSG     <- 29902L

# Field names as delivered by the EPA GeoServer WFS export (2026-07-31). These differ
# from the names in the delivered README.txt, which documented an earlier ArcGIS export:
# README said Associat_1 / Associat_2 / ha / DRAINAGE / TEXTURE / DEPTH; the WFS gives
# Associati0 / Associati1 / Ha / Drainage / Texture / Depth, and adds PlainEngli and
# URLtext. Same 25,143 features and same CRS, so it is the same dataset under a different
# truncation. Check both spellings rather than assuming either.
EXPECTED_FIELDS <- c("Associatio", "Associati0", "Associati1", "Texture_Su",
                     "Ha", "Drainage", "Texture", "Depth", "SOC", "URL")

# Canonical names used downstream, mapped from whichever spelling arrived.
FIELD_ALIASES <- list(
  assoc_unit   = c("Associatio"),
  assoc_symbol = c("Associati0", "Associat_1"),
  assoc_name   = c("Associati1", "Associat_2"),
  texture_sub  = c("Texture_Su"),
  area_ha      = c("Ha", "ha"),
  drainage     = c("Drainage", "DRAINAGE"),
  texture      = c("Texture", "TEXTURE"),
  depth        = c("Depth", "DEPTH"),
  soc          = c("SOC")
)

dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

# Accept whichever format arrives. GeoPackage first, since it is the requested one.
candidates <- c(
  file.path(IN_DIR, "SOIL_SISNationalSoils.gpkg"),
  file.path(IN_DIR, "SOIL_SISNationalSoils.shp")
)
src <- candidates[file.exists(candidates)][1]

if (is.na(src)) {
  stop(
    "Irish soils layer not found.\n",
    "  Looked for: ", paste(candidates, collapse = "\n              "), "\n",
    "  The delivered folder has the .shx index but no .shp and no .dbf, so the layer\n",
    "  cannot be opened. Request a re-export carrying geometry AND attributes,\n",
    "  ideally as GeoPackage. Expect ", EXPECTED_FEATURES, " polygons in EPSG:",
    EXPECTED_EPSG, ".",
    call. = FALSE
  )
}

message("Reading: ", src)
soils <- sf::st_read(src, quiet = TRUE)

# ---- Validate against what the sidecars promised -----------------------------------
# Fail loudly on a short or reprojected export rather than silently analysing the wrong
# thing. A partial export is the failure mode most likely to go unnoticed.

n <- nrow(soils)
message(sprintf("Features: %d (expected %d)%s", n, EXPECTED_FEATURES,
                if (n == EXPECTED_FEATURES) "" else "  <-- MISMATCH"))

epsg <- sf::st_crs(soils)$epsg
message(sprintf("CRS: EPSG:%s (expected %d)%s",
                ifelse(is.na(epsg), "unknown", epsg), EXPECTED_EPSG,
                if (!is.na(epsg) && epsg == EXPECTED_EPSG) "" else "  <-- CHECK"))

present <- EXPECTED_FIELDS %in% names(soils)
if (!all(present)) {
  message("Missing expected fields: ", paste(EXPECTED_FIELDS[!present], collapse = ", "))
  message("Fields actually present: ", paste(names(soils), collapse = ", "))
  message("(A GeoPackage export keeps full field names, so Associatio/Associat_1/",
          "Associat_2/Texture_Su may legitimately appear unabbreviated.)")
}

# ---- Report the category vocabulary -------------------------------------------------
# This is the point of the first run. The mapping onto IPCC soil classes gets written
# once these values are known, not before.

# Resolve each canonical name to whichever spelling actually arrived.
resolve <- function(key) {
  hit <- FIELD_ALIASES[[key]][FIELD_ALIASES[[key]] %in% names(soils)]
  if (length(hit)) hit[1] else NA_character_
}
FIELD <- vapply(names(FIELD_ALIASES), resolve, character(1))
message("\nResolved fields: ",
        paste(sprintf("%s=%s", names(FIELD), FIELD), collapse = ", "))

report_levels <- function(key, max_show = 40) {
  f <- FIELD[[key]]
  if (is.na(f)) { cat(sprintf("\n%s: FIELD ABSENT\n", key)); return(invisible(NULL)) }
  v <- soils[[f]]
  if (is.numeric(v)) {
    u <- sort(unique(v))
    cat(sprintf("\n%s (%s): NUMERIC, %d distinct, range %.2f to %.2f\n",
                key, f, length(u), min(u, na.rm = TRUE), max(u, na.rm = TRUE)))
  } else {
    u <- sort(unique(as.character(v)))
    cat(sprintf("\n%s (%s): %d distinct values\n", key, f, length(u)))
    cat(paste0("  ", utils::head(u, max_show), collapse = "\n"), "\n")
    if (length(u) > max_show) cat(sprintf("  ... and %d more\n", length(u) - max_show))
  }
}
invisible(lapply(c("soc", "drainage", "texture", "depth"), report_levels))

# ---- Derived output ------------------------------------------------------------------
# Area by SOC x DRAINAGE class. Areas are computed from the geometry rather than trusting
# the delivered `ha` column, and both are written so they can be checked against each
# other; a systematic gap between them would indicate a clipped or reprojected export.

stopifnot(!is.na(FIELD[["drainage"]]), !is.na(FIELD[["soc"]]))

d <- sf::st_drop_geometry(soils)
d$area_ha_geom <- as.numeric(sf::st_area(soils)) / 10000

# CRITICAL: SOC, Depth and Texture are NA for a large minority of polygons, and an
# aggregate() that drops those rows silently loses a third of the national area. NAs are
# therefore made explicit as the string "(none)" before grouping, so every one of the
# 25,143 polygons survives into the derived table and the coverage gap is visible rather
# than invisible.
nz <- function(x) { x <- as.character(x); x[is.na(x) | trimws(x) == ""] <- "(none)"; x }

tab <- data.frame(
  assoc_symbol = nz(d[[FIELD[["assoc_symbol"]]]]),
  assoc_name   = nz(d[[FIELD[["assoc_name"]]]]),
  drainage     = nz(d[[FIELD[["drainage"]]]]),
  texture      = nz(d[[FIELD[["texture"]]]]),
  depth        = if (!is.na(FIELD[["depth"]])) nz(d[[FIELD[["depth"]]]]) else "(none)",
  soc          = ifelse(is.na(d[[FIELD[["soc"]]]]), NA_real_, d[[FIELD[["soc"]]]]),
  soc_present  = !is.na(d[[FIELD[["soc"]]]]),
  area_ha_geom = d$area_ha_geom,
  area_ha_stated = if (!is.na(FIELD[["area_ha"]])) d[[FIELD[["area_ha"]]]] else NA_real_,
  n_polygons   = 1L,
  stringsAsFactors = FALSE
)
tab$soc_key <- ifelse(tab$soc_present, sprintf("%.8f", tab$soc), "(none)")

agg <- aggregate(
  cbind(area_ha_geom, area_ha_stated, n_polygons) ~
    assoc_symbol + assoc_name + drainage + texture + depth + soc_key + soc_present,
  data = tab, FUN = function(x) sum(x, na.rm = TRUE), na.action = na.pass
)
agg$soc <- suppressWarnings(as.numeric(agg$soc_key))
agg$soc_key <- NULL
agg <- agg[order(-agg$area_ha_geom), ]

stopifnot(sum(agg$n_polygons) == nrow(soils))   # nothing dropped

out <- file.path(OUT_DIR, "irish-soils-area-by-class.csv")
write.csv(agg, out, row.names = FALSE)

tot  <- sum(agg$area_ha_geom)
with_soc <- sum(agg$area_ha_geom[agg$soc_present])
peat <- agg[agg$texture == "Peat", ]

message(sprintf("\nWrote: %s\n  %d classes, %d polygons (all retained), %.0f ha total",
                out, nrow(agg), sum(agg$n_polygons), tot))
message(sprintf("  Area check: geometry %.0f ha vs stated %.0f ha (%.2f%%).",
                tot, sum(agg$area_ha_stated, na.rm = TRUE),
                100 * (tot / sum(agg$area_ha_stated, na.rm = TRUE) - 1)))
message(sprintf("  SOC populated on %.0f ha (%.1f%% of area); ABSENT on %.0f ha (%.1f%%).",
                with_soc, 100 * with_soc / tot, tot - with_soc,
                100 * (tot - with_soc) / tot))
message(sprintf("  Peat texture: %.0f ha, of which SOC populated %.0f ha (%.1f%%).",
                sum(peat$area_ha_geom), sum(peat$area_ha_geom[peat$soc_present]),
                100 * sum(peat$area_ha_geom[peat$soc_present]) / sum(peat$area_ha_geom)))
wm <- function(x, w) sum(x * w) / sum(w)
message(sprintf("  Area-weighted mean SOC where present: %.1f t C/ha (mineral only: %.1f).",
                wm(agg$soc[agg$soc_present], agg$area_ha_geom[agg$soc_present]),
                wm(agg$soc[agg$soc_present & agg$texture != "Peat"],
                   agg$area_ha_geom[agg$soc_present & agg$texture != "Peat"])))

# ---- Next step, once the vocabulary above is known ------------------------------------
# Write the mapping from Association_Unit / TEXTURE / SOC onto the IPCC 2019 Table 2.3
# soil classes (HAC, LAC, SAN, POD, VOL, WET) and the organic/mineral split, as an
# explicit lookup table checked into this directory. Do not infer it in the render:
# the manuscript reads the CSV and does the IPCC arithmetic in visible base-R chunks.
