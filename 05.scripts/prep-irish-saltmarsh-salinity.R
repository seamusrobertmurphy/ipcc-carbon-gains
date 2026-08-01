# prep-irish-saltmarsh-salinity.R
#
# Stage 1: join Irish Annex I saltmarsh polygons to the transitional water bodies that
# contain them, attach measured salinity where it exists, and write a small CSV that the
# manuscript reads with base read.csv.
#
# WHY THIS EXISTS
# ---------------
# Wetlands Supplement Table 4.14 sets CH4 to zero above 18 ppt salinity and to
# 193.7 kg CH4/ha/yr below it, which at AR6 GWP-100 costs 5.23 t CO2e/ha/yr and reverses the
# sign of the tidal marsh pathway. No published dataset says how much Irish saltmarsh sits
# below that threshold. This script is the first attempt to bound it.
#
# INPUTS
# ------
# 1. NPWS Saltmarsh Monitoring Project 2006-2008, national saltmarsh resource, revised 2011.
#    https://www.npws.ie/sites/default/files/general/saltmarsh-monitoring-project-2006-2008.zip
#    13,071 polygons, EPSG:29902 (TM65 Irish Grid). Field HABITAT carries the Annex I code.
# 2. EPA WFD transitional water bodies, latest status.
#    https://gis.epa.ie/geoserver/EPA/wfs  layer EPA:TWB_WFD_LatestStatus
#    195 polygons, retrieved as EPSG:2157 (Irish Transverse Mercator).
# Both downloaded 2026-08-01. See 02.inputs/IRL/README.md.
#
# THE SALINITY DATA, AND ITS LIMITS
# ---------------------------------
# Salinities are from Inland Fisheries Ireland, "Fish Stock Survey of Transitional
# Waterbodies around the Republic of Ireland, 2015" (WFD-TW-Report-2015). GREY LITERATURE,
# but a primary measurement source.
#
# THREE LIMITATIONS THAT MUST TRAVEL WITH ANY RESULT FROM THIS SCRIPT:
#   (a) These are WATER-COLUMN salinities at low-tide beach-seine stations, not marsh soil
#       porewater. Table 4.14's threshold is a marsh salinity. They are a proxy, not the
#       same quantity, and porewater is generally fresher than the flooding water column.
#   (b) They are single-survey ranges from 2015, not annual means. An estuary recorded
#       between 0.3 and 25 ppt spans the threshold rather than sitting on one side of it.
#   (c) Only 9 of 195 transitional water bodies were surveyed, so most Irish saltmarsh is
#       simply unclassified. The result below is a lower bound on exposure, never a total.
#
# This script therefore reports EXPOSURE, i.e. how much saltmarsh sits in systems known to
# record sub-18 ppt water, and how much cannot be classified at all. It does not claim to
# measure marsh salinity.

suppressPackageStartupMessages(library(sf))

SM_PATH  <- "../02.inputs/IRL/Saltmarsh/smp_national_sm_resource_revised_GIS_2011.shp"
TWB_PATH <- "../02.inputs/IRL/WaterBodies/TWB_WFD_LatestStatus.shp"
OUT_DIR  <- "../02.inputs/derived"
EPSG     <- 2157   # Irish Transverse Mercator, metres, the modern national grid

dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)
stopifnot(file.exists(SM_PATH), file.exists(TWB_PATH))

# Inland Fisheries Ireland 2015, salinity recorded at beach-seine stations, ppt.
# Names are matched against the EPA TWB `Name` field. Where IFI surveyed a system whose
# TWB name differs, the pattern is given as a regular expression.
ifi <- data.frame(
  pattern  = c("^Avoca Estuary$", "^Erne Estuary$", "^Gweebarra Estuary$",
               "^Boyne Estuary$", "^Camus Bay$", "^Castlemaine Harbour$",
               "Ballysadare", "Kinvara", "^Tralee Bay"),
  sal_min  = c(0.059, 10.1, 0.09, 0.33, 8.2, 0.072, 0.39, 2.6, 37.4),
  sal_max  = c(6.43, 21.5, 22.1, 25.42, 29.4, 33.6, 18.5, 41.3, 41.2),
  stringsAsFactors = FALSE
)

message("Reading saltmarsh ...")
sm <- sf::st_read(SM_PATH, quiet = TRUE)
message("Reading transitional water bodies ...")
twb <- sf::st_read(TWB_PATH, quiet = TRUE)

sm  <- sf::st_transform(sm,  EPSG)
twb <- sf::st_transform(twb, EPSG)
sm  <- sf::st_make_valid(sm)
twb <- sf::st_make_valid(twb)

# Stratify by habitat. The SMP layer's H_EU_Code distinguishes three things that must not
# be conflated:
#   - CONFIRMED Annex I saltmarsh: codes 1310, 1330, 1410, 1420 and their mosaics, field
#     surveyed.
#   - POTENTIAL Annex I saltmarsh: the same codes prefixed "Potential", mapped by desk
#     study rather than visited. Included as a separate stratum, never merged into the
#     confirmed figure.
#   - NOT saltmarsh: code 1140 is mudflat and sandflat, an Annex I habitat but not tidal
#     marsh, and is excluded from every saltmarsh total below.
# Spartina swards carry no Annex code because the species is introduced and was removed as
# a qualifying interest. They are retained as their own stratum because Table 4.12 makes no
# species distinction: 1,520 ha of invasive sward is still vegetated tidal marsh and would
# count identically under a Tier 1 reading.
code <- as.character(sm$H_EU_Code)
sm$stratum <- ifelse(grepl("1140", code), "Mudflat/sandflat (not saltmarsh)",
              ifelse(grepl("^Potential", code), "Annex I saltmarsh, potential",
              ifelse(grepl("1310|1330|1410|1420", code), "Annex I saltmarsh, confirmed",
              ifelse(grepl("Spartina", sm$HABITAT, ignore.case = TRUE), "Spartina sward",
                     "Other, non-Annex"))))
sm$is_annex <- sm$stratum == "Annex I saltmarsh, confirmed"
sm$area_ha  <- as.numeric(sf::st_area(sm)) / 10000

message("Habitat strata:")
for (s in sort(unique(sm$stratum)))
  message(sprintf("  %-34s %8.1f ha  %5d polygons",
                  s, sum(sm$area_ha[sm$stratum == s]), sum(sm$stratum == s)))

# Assign each marsh polygon to the transitional water body it overlaps most.
message("Intersecting ...")
hits <- sf::st_intersects(sm, twb)
sm$twb_name <- NA_character_
multi <- 0L
for (i in seq_len(nrow(sm))) {
  h <- hits[[i]]
  if (!length(h)) next
  if (length(h) == 1L) {
    sm$twb_name[i] <- twb$Name[h]
  } else {
    multi <- multi + 1L
    a <- suppressWarnings(as.numeric(sf::st_area(
      sf::st_intersection(sf::st_geometry(sm)[i], sf::st_geometry(twb)[h]))))
    sm$twb_name[i] <- twb$Name[h[which.max(a)]]
  }
}
message(sprintf("Assigned to a water body: %d of %d polygons (%d resolved by largest overlap).",
                sum(!is.na(sm$twb_name)), nrow(sm), multi))

# Attach salinity where IFI surveyed the system.
sm$sal_min <- NA_real_; sm$sal_max <- NA_real_
for (k in seq_len(nrow(ifi))) {
  m <- !is.na(sm$twb_name) & grepl(ifi$pattern[k], sm$twb_name)
  sm$sal_min[m] <- ifi$sal_min[k]; sm$sal_max[m] <- ifi$sal_max[k]
}

classify <- function(lo, hi) {
  ifelse(is.na(hi), "Not surveyed",
  ifelse(hi < 18,   "Below 18 ppt throughout",
  ifelse(lo >= 18,  "Above 18 ppt throughout",
                    "Spans 18 ppt")))
}
sm$salinity_class <- classify(sm$sal_min, sm$sal_max)
sm$salinity_class[is.na(sm$twb_name)] <- "Outside any transitional water body"

agg <- aggregate(cbind(area_ha, n_polygons) ~ salinity_class + stratum,
                 data = transform(sf::st_drop_geometry(sm), n_polygons = 1L), FUN = sum)
agg <- agg[order(-agg$area_ha), ]
agg$area_ha <- round(agg$area_ha, 1)

out <- file.path(OUT_DIR, "irish-saltmarsh-salinity.csv")
write.csv(agg, out, row.names = FALSE)

stopifnot(sum(agg$n_polygons) == nrow(sm))

message("\nWrote: ", out)
an <- agg[agg$stratum == "Annex I saltmarsh, confirmed", ]
message(sprintf("\n--- Annex I saltmarsh (confirmed), %.0f ha total ---", sum(an$area_ha)))
for (i in seq_len(nrow(an)))
  message(sprintf("  %-38s %8.1f ha  (%4.1f%%)  %d polygons",
                  an$salinity_class[i], an$area_ha[i],
                  100 * an$area_ha[i] / sum(an$area_ha), an$n_polygons[i]))

exposed <- sum(an$area_ha[an$salinity_class %in%
                          c("Below 18 ppt throughout", "Spans 18 ppt")])
message(sprintf("\nExposed to the Table 4.14 sub-18 ppt default (below or spanning): %.1f ha.",
                exposed))
message(sprintf("At 193.7 kg CH4/ha/yr and AR6 GWP-100 = 27.0, that is %.2f t CO2e/ha/yr, or %.1f kt CO2e/yr over that area.",
                193.7 / 1000 * 27.0, exposed * 193.7 / 1000 * 27.0 / 1000))
message("\nNOTE: a lower bound. Only 9 of 195 transitional water bodies have measured salinity,\nand those are water-column, not marsh porewater. See the header of this script.")
