# map-furniture.R
#
# Graticule, north arrow, bar scale and projection label, shared by make-maps.R and
# make-input-maps.R so the two cannot drift apart. Sourced, never run on its own.
#
# Both functions read the current plot region with par("usr") rather than taking the
# requested limits, because plotting an sf object with asp = 1 expands the shorter axis and
# the graticule must be built on what was actually drawn, not on what was asked for.
#
# Placement convention for every map in this project: graticule labels in the left and
# bottom margins, and the north arrow, bar scale and EPSG in the LOWER RIGHT of the panel.

suppressPackageStartupMessages(library(sf))

# One-degree graticule over the data, thin and translucent so it reads as a graticule and
# not as a boundary. Labels go in the margins, so they cannot sit on the map.
map_graticule <- function(crs, lon, lat, cex = 0.44) {
  u <- par("usr")
  bbp <- sf::st_as_sfc(sf::st_bbox(c(xmin = u[1], xmax = u[2], ymin = u[3], ymax = u[4]),
                                   crs = crs))
  g <- sf::st_graticule(bbp, crs = sf::st_crs(crs), lon = lon, lat = lat)
  plot(sf::st_geometry(g), add = TRUE, lwd = 0.35,
       col = adjustcolor("#3A3A3A", alpha.f = 0.30))
  ew <- g[g$type == "E", ]; ns <- g[g$type == "N", ]
  text(ew$x_start, u[3], parse(text = ew$degree_label), pos = 1, offset = 0.25,
       cex = cex, col = "#4A4A4A", xpd = NA)
  text(u[1], ns$y_start, parse(text = ns$degree_label), pos = 2, offset = 0.25,
       cex = cex, col = "#4A4A4A", xpd = NA)
}

# A bar scale rather than a representative fraction, because the manuscript rescales these
# PNGs and a printed ratio would then be false. On an unprojected global map both the bar
# and the arrow are omitted: scale varies with latitude there, and a single bar would be a
# lie. Pass scalebar = FALSE and north = FALSE for that case and only the CRS is declared.
# cex scales every label, so a map drawn at its printed size can keep text of 7 pt or more.
# mid = FALSE drops the middle scale label where large text would crowd it.
map_furniture <- function(epsg_label, bar_km = 100, scalebar = TRUE, north = TRUE, cex = 1,
                          mid = TRUE) {
  u <- par("usr"); w <- u[2] - u[1]; h <- u[4] - u[3]
  x1 <- u[2] - 0.035 * w
  y0 <- u[3] + 0.050 * h
  if (scalebar) {
    x0 <- x1 - bar_km * 1000
    xm <- (x0 + x1) / 2
    hb <- 0.009 * h
    rect(x0, y0, xm, y0 + hb, col = "#3A3A3A", border = "#3A3A3A", lwd = 0.4)
    rect(xm, y0, x1, y0 + hb, col = "#FFFFFF", border = "#3A3A3A", lwd = 0.4)
    text(c(x0, xm, x1), y0 + hb, labels = c("0", if (mid) bar_km / 2 else "", paste(bar_km, "km")),
         pos = 3, offset = 0.12, cex = 0.42 * cex, col = "#3A3A3A", xpd = NA)
    if (north) {
      nx <- (x0 + x1) / 2
      ny <- y0 + 0.075 * h
      arrows(nx, ny, nx, ny + 0.060 * h, length = 0.04, lwd = 1.1, col = "#3A3A3A")
      text(nx, ny + 0.060 * h, "N", pos = 3, offset = 0.12, cex = 0.48 * cex, font = 2,
           col = "#3A3A3A")
    }
  }
  text(x1, y0 - 0.008 * h, epsg_label, adj = c(1, 1), cex = 0.40 * cex, col = "#4A4A4A")
}
