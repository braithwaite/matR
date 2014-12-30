#' ---
#' title: "Principal components analysis"
#' author: ""
#' date: ""
#' ---

#' The `princomp.biom()` function plots principal components of a `biom` object.
#' The effect of some common options is shown below.
#' Use `dim=` to determine which principal components are plotted; 
#' use `method=` to choose a dissimilarity measure (display the possibilities with `?distx.biom`);
#' use `labels=` to control point labeling;
#' use `col=` to control point colors; 
#' use `cex=` to control point size;
#' use `main=` for a title.

princomp (xx3, dim=1:2, main="PCoA with bray-curtis distance", labels="", method="bray-curtis")

point_colors <- c('red','red','purple','purple','purple','blue','blue')
label_positions <- c(2,4,2,4,4,4,2)
princomp (xx1, dim=c(1,3,2), cex=1.5, col=point_colors, label.cex=1, label.pos=label_positions, label.col='grey50', label.font=3)

#+ fig.width=10, fig.retina=NULL
s <- split.screen(c(2,3))
point_labels <- paste(" ", LETTERS[1:7])
 for (i in 1:6) {
	screen(s[i])
	par (tck=0.05, mgp=c(1.5,0.25,0), cex.axis=0.5, lab=c(10,1,0))
	princomp (xx1, dim=i, labels=point_labels, label.pos=3)
	}
	
#+ echo=FALSE 
close.screen(all=TRUE)

#' ************* Complete help is available with `?princomp.biom`.
#' built on other functions,
#' so for sophisticated graphics tweaks, parameters from those functions can be applied.
#' do your own research.
#' see also `?scatterplot3d`, `?points`, `?text`
#' `labels.cex` and others are passed to `text()`

columns (xx1, "host_common_name|samp_store_temp")
princomp (xx1, dim=1:2, map=c(col="host_common_name", pch="samp_store_temp"),
  col=c(Mouse="brown", cow="red", "striped bass"="blue"),
  pch=c("-80"="+","NA"="*"), cex=2, label.pos=c(4,4,2,2,2,2,4), label.font=3)

#' labeling from metadata, 
#' transformed data, labeling from metadata, and modified perspective

columns (xx2, "material")
princomp (transform (xx2, t_Log), map=c(col="material"), labels="$$project.id", 
  angle=50, mar=c(1,1,0,0))
