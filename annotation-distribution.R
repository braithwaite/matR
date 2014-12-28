#' ---
#' title: "Distribution of annotations in metagenomes"
#' author: ""
#' date: ""
#' ---

#' The `barchart.biom()` function extends matR using the ggplot2 package,
#' so this preparation is needed:

library(matR)
library(ggplot2)
source("https://mg-rast.github.io/matR/local-workbench.R")

#' First, for demonstration purposes, we create a sample `biom` object of several metagenomes,
#' then a barchart summarizing content across the top-level taxonomic hierarchy.

writeLines (colnames (xx1), "my_ids.txt")
zz <- biomRequest (file="my_ids.txt", request="organism", group_level="phylum")
barchart.biom (zz, raw=FALSE)

#' The annotations displayed in the plot can be restricted.

barchart.biom (zz, "Bacteria", raw=FALSE)

#' And again, for a still more focused view.

barchart.biom (zz, c("Bacteria","Firmicutes"), raw=FALSE)

#' The function `boxplot.biom()` is useful for comparing total annotations across metagenomes.
#' This is an important step, since it would likely be misleading to analyze together
#' without transformation metagenomes with very different total annotation counts.

xx2t <- transform (xx2, t_Log)			 # revise
boxplot (xx2t, main="log transformed data", notch=FALSE)

#' Just above, transformed ("normalized") counts were plotted whereas below,
#' a separate plot of raw counts is added.  Metadata in used to color the plot, too.

boxplot (xx2t, xx2, x.main="log of data", y.main="raw data", map=c(col="material"), notch=FALSE,
  col=c("freshwater"="darkorange", "hot spring"="slateblue", "hot spring ; microbial mat"="chocolate4"))

#' Here metadata is used to label the boxes of the plot. ...

boxplot (transform (xx4, t_Log), names="$$sample.data.sample_name", notch=FALSE)

#' The final example again shows two plots.  However, instead of juxtaposing raw and
#' normalized counts, here two slightly different normalizations are shown.
#' Such a visualization can help compare the effects of different normalization procedures.

xx2tt <- transform (xx2, t_Threshold=list(entry.min=5), t_Log)
boxplot (xx2t, xx2tt, notch=FALSE, x.main="log transformation", y.main="low counts removed, then log transformation")
