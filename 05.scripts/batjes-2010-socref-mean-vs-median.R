# SUPERSEDED 2026-08-01. NOT PART OF THE STUDY.
#
# This analysis now lives inside the manuscript, in the chunks `tbl-batjes-bias` and
# `batjes-area-weighted`, which encode the same Batjes table and compute the same bias at
# render time. Its output, 03.outputs/batjes-2010-socref-bias.csv, is read by nothing.
#
# Kept only as the exploratory original. The project rule is that if an analysis is not in
# the manuscript it is not part of the study, so do not cite anything from here: cite the
# manuscript chunks, which are the version that is verified and rendered.
#
# ---------------------------------------------------------------------------------------

# Mean-versus-median bias in the IPCC Tier 1 SOCref defaults.
#
# IPCC 2019 Refinement Vol.4 Ch.2 Table 2.3 publishes arithmetic MEANS from
# Batjes (2010). Batjes also published MEDIANS with median absolute deviation.
# For skewed SOC distributions the median is the robust statistic, so the
# published defaults sit above the robust central estimate.
#
# Source table: Batjes (2010), reproduced in
# 04.references/ipcc-guidelines/IPCC-SOCref-Study-Batjes-2010.pdf
# Cross-checked against IPCC 2019 Table 2.3: the mean column matches the
# published defaults exactly.
#
# Base R only. Run: Rscript 02.inputs/batjes-2010-socref-mean-vs-median.R

batjes <- read.csv(text = "
climate,soil,n,mean,sd,median,mad
T1,HAC,114,51,28,46,20
T1,LAC,84,44,22,36,12
T1,SAN,11,52,30,47,14
T1,VOL,10,96,48,74,16
T1,WET,12,82,73,58,36
T2,HAC,137,60,30,53,19
T2,LAC,271,52,25,46,16
T2,SAN,43,46,31,41,22
T2,VOL,14,77,40,66,22
T2,WET,33,49,27,49,16
T3,HAC,226,40,22,35,14
T3,LAC,326,38,19,33,12
T3,SAN,76,27,15,23,11
T3,WET,55,68,45,53,24
T4,HAC,554,21,13,17,7
T4,LAC,135,19,11,17,7
T4,SAN,164,9,5,8,3
T4,WET,32,22,11,20,7
W1,HAC,489,64,33,59,21
W1,LAC,183,55,29,50,19
W1,SAN,39,36,26,29,11
W1,POD,9,143,65,142,54
W1,VOL,42,138,56,143,28
W1,WET,28,135,101,94,49
W2,HAC,781,24,16,19,9
W2,LAC,41,19,10,18,7
W2,SAN,338,10,5,9,3
W2,VOL,10,84,88,33,23
W2,WET,49,74,45,66,34
C1,HAC,334,81,40,74,28
C1,LAC,6,76,48,66,18
C1,SAN,126,51,39,42,22
C1,POD,45,128,61,115,41
C1,VOL,28,136,52,137,28
C1,WET,42,128,55,113,36
C2,HAC,177,43,24,38,17
C2,SAN,10,13,7,12,3
", stringsAsFactors = FALSE)

# Percentage by which the published mean exceeds the robust median.
batjes$bias_pct <- round(100 * (batjes$mean - batjes$median) / batjes$median, 1)

# Coefficient of variation, for comparison against the stated +/- error in
# Table 2.3, which is a 95% confidence interval on the MEAN and therefore
# narrows with n while saying nothing about the spread of the underlying soils.
batjes$cv_pct <- round(100 * batjes$sd / batjes$mean, 1)

cat("\n=== Mean-vs-median bias in IPCC Table 2.3 SOCref defaults ===\n\n")
print(batjes[order(-batjes$bias_pct), c("climate","soil","n","mean","median","bias_pct","cv_pct")],
      row.names = FALSE)

cat("\n--- Summary ---\n")
cat(sprintf("Cells: %d\n", nrow(batjes)))
cat(sprintf("Mean exceeds median in %d of %d cells (%.0f%%)\n",
            sum(batjes$bias_pct > 0), nrow(batjes),
            100 * mean(batjes$bias_pct > 0)))
cat(sprintf("Median bias across cells: %.1f%%\n", median(batjes$bias_pct)))
cat(sprintf("Range: %.1f%% to %.1f%%\n", min(batjes$bias_pct), max(batjes$bias_pct)))

# The systems this project is about: wet soils, volcanic soils, tropical montane.
target <- batjes[batjes$soil %in% c("WET","VOL") | batjes$climate == "T1", ]
cat(sprintf("\nWET/VOL soils and tropical montane (n=%d cells): median bias %.1f%%, max %.1f%%\n",
            nrow(target), median(target$bias_pct), max(target$bias_pct)))

other <- batjes[!(batjes$soil %in% c("WET","VOL") | batjes$climate == "T1"), ]
cat(sprintf("All other cells (n=%d): median bias %.1f%%, max %.1f%%\n",
            nrow(other), median(other$bias_pct), max(other$bias_pct)))

cat(sprintf("\nCV exceeds the stated Table 2.3 error in every cell. Median CV: %.1f%%\n",
            median(batjes$cv_pct)))

dir.create("03.outputs", showWarnings = FALSE)
write.csv(batjes, "03.outputs/batjes-2010-socref-bias.csv", row.names = FALSE)
cat("\nWritten: 03.outputs/batjes-2010-socref-bias.csv\n")
