#' ---
#' title: "Distribution of annotations in metagenomes"
#' author: ""
#' date: ""
#' ---

#' This tutorial discusses specialized versions of the generic functions `barchart()` and `boxplot()`.
#' The latter is part of the matR package but `barchart.biom()` is an extension using the ggplot2 package,
#' so this preparation is needed to apply it:

library(matR)
library(ggplot2)		# should require() within barchart.biom()
#source("http://mg-rast.github.io/matR/local-workbench.R")
barchart.biom <- function (...) { }
source("http://braithwaite.github.io/matR/local-workbench.R")

#' Below, a `biom` object of several metagenomes is created for demonstration,
#' and then a barchart summarizing taxonomic content across the top hierarchy level.

#+ warning=FALSE, message=FALSE, results="hide"
writeLines (colnames (xx1), "my_ids.txt")
zz <- biomRequest (file="my_ids.txt", request="organism", group_level="phylum")
barchart.biom (zz, raw=FALSE)

#' Annotations displayed in the plot can be restricted.

barchart.biom (zz, "Bacteria", raw=FALSE)

#' And again, for a still more focused view.

barchart.biom (zz, c("Bacteria","Firmicutes"), raw=FALSE)

#' The function `boxplot.biom()` summarizes the annotation count distribution of each metagenome.
#' First, here is a boxplot of the log transformed counts.

xx2t <- transform (xx2, t_Log)			 # revise
boxplot (xx2t, main="log transformed data", notch=FALSE)

#' It's possible to display two plots in the same frame,
#' as in the next example to assist comparison of raw and transformed counts.
#' Adjacent plots illustrate how effectively (or not) transformation aligns count distributions that may vary greatly.
#' Also note how values of the "material" metadata field are used to assigned colors.

boxplot (xx2, xx2t, x.main="raw data", y.main="log transformed data", map=c(col="material"), notch=FALSE,
  col=c("freshwater"="slateblue", "hot spring"="chocolate4", "hot spring ; microbial mat"="darkorange"),
  outline=FALSE)

#' Here outliers were simply ignored due to `outline=FALSE` but they deserve, of course, careful attention.
#' Mapping metadata to graphical parameters, as above with `map=`, is described in the principal components tutorial in more detail.
#' Below, the prefix `$$` effects a literal substitution of metadata, labeling the axis with sample names.

#+ warning=FALSE
boxplot (transform (xx4, t_Log), names="$$sample.data.sample_name", notch=FALSE)

#' A juxtaposition of two plots, rather than show raw and normalized counts as above,
#' may also present two different normalizations.

xx2tt <- transform (xx2, t_Threshold=list(entry.min=5), t_Log)
boxplot (xx2t, xx2tt, notch=FALSE, x.main="log transformed data", y.main="low counts removed, then log transformed")

#' This could help choose a normalization procedure and tune its parameters.
