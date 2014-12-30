#' ---
#' title: "Heatmap examples using image.biom()"
#' author: ""
#' date: ""
#' ---

#' optimize margin in all cases.
#' have 4-5 different palettes --- accordingly, show how to change color first.

#' The generic `image()` function is defined by `matR` for class `biom` to produce a heatmap-dendrogram.
#' Heatmaps of raw counts are typically not very revealing.  A log transformation makes interesting things more apparent.

library(matR)
xx1t <- transform (xx1, t_Log)
xx2t <- transform (xx2, t_Log)

#' A title is the simplest of graphical adjustments you may want to make.
# image (xx2t, main="title")

#' As with other functions, metadata can be directed substituted in some places with the `$$` shorthand.
image (xx2t, labCol="$$project.id", labRow="$$taxonomy1")

#' Like other matR functions and indeed all graphics in R, this is a layer built upon other layers.

#' Heatmaps, more than any other analysis, may require fiddling with margins.
#' The most important settings for this are shown now.
#' Under `?heatmap.2` read about `margins`, `lwid`, and `lhei` especially.
#' Unfortunately, getting the knack of adjusting them is a trial-and-error process.
#' Of necessity, they're used repeatedly in the rest of the tutorial.
image (xx2t,
	labCol="$$material",
	margins=c(9,6),
	lwid=c(1,2.5),lhei=c(1,10),
	cexRow=0.5,cexCol=0.8)

#' Setting `rows=` and/or `columns=` allows a partial heatmap.
image (xx2t, labCol="$$metagenome.id", labRow="$$taxonomy2", rows=rows(xx2t,"taxonomy1")=="Eukaryota")

#' Of course, an alternate way to accomplish the same thing is to select part of the `biom` object explicitly.
image (xx2t [rows(xx2t,"taxonomy1")=="Eukaryota", columns(xx2t,"project.id")=="mgp20"])

#' The dendrogram can be omitted (in which case it helps to trim all the whitespace left vacant).
# image (xx2t, dendrogram="none")
image (xx2t, dendrogram="none", lwid=c(2,9), lhei=c(2,10), margins=c(7,7), xlab="metagenome", ylab="phylum")

#' Here's a heatmap with many more rows than previous examples.
nrow(xx1t)
image(xx1t, labRow=matR:::abbrev(rownames(xx1t),50), srtCol=30, cexRow=0.3, sepcol="black", sepwidth=c(0.001,0), colsep=0:(ncol(xx1t)+1), rowsep=NULL, lwid=c(1,4))

#' Changing the color scheme is easy.  Here we use some predefined colors that were
#' generated with the nice interactive utility `colorspace::choose_palette()`.
blue_palette <- c("#023FA5", "#2949A4", "#3B53A6", "#495DA8", "#5666AB", "#6170AF", "#6C79B3", "#7781B7",
"#818ABB", "#8A92BE", "#939BC2", "#9CA2C6", "#A5AAC9", "#ADB1CD", "#B5B8D0", "#BCBFD3", "#C3C5D6",
"#C9CBD8", "#CFD1DB", "#D5D6DD", "#D9DADF", "#DDDEE0", "#E1E1E2", "#E2E2E2")
image(xx1t, labRow=matR:::abbrev(rownames(xx1t),50), cexRow=0.3, col=blue_palette)

#' Optionally, a combined color key and histogram of annotation count values can be plotted.
image(xx1t, col=blue_palette, key=TRUE, lwid=c(1,2),lhei=c(1,2),
	margins=c(5,5),
	labRow=NA, labCol=NA,
	key.title="key and histogram",
	key.par=list(cex.axis=0.8))				# not all working: cex.lab=0.8, cex.main=0.8, cex.axis=0.6

#' gplots::heatmap.2() has many other features, all of which are available via `image.biom()`
#' for instace use `lmat=` to reposition elements.  give example rotated 90 degrees.
#' For another instance, it's possible insist on a grouping or ordering for the dendrogram.
#' I encourage you to read about them: it might be very useful to consult `?gplots::heatmap.2()`.

#' Heatmaps are particularly prone to screwing up the graphics state of R.
#' Try `graphics.off()` for the error `Invalid graphics state` or similar.


#' Dendrograms can be costly (i.e. lengthy) to compute.
#' Therefore, it is possible to reuse computed dendrograms when calling the function repeatedly to make minor graphics adjustments.
#' Bear in mind, no sanity checking is done.  The dendrogram passed with `rerender=` had better be right!

#' Analysis restricted by significance test p-values:

p <- rowstats (xx2t, test="t-test-unpaired", groups="$$material") $ p.value
p [is.na(p)] <- p [is.nan(p)] <- FALSE
# then we would restrict rows as above:
# image (xx2t [rows = p < 0.05, ], labCol="$$material")



