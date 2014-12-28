#' ---
#' title: "Normalizing annotation data for analysis"
#' author: ""
#' date: ""
#' ---

#' Normalization is mathematical transformation of raw abundance counts to assist comparisons.
#' The function `transform.biom()` defines some standard tranformations for `biom` objects
#' that are often suitably applied preliminary to analysis.
#' 
#' If you need a transformation that is not predefined, the conversion
#' `as.matrix(x, TRUE)` from `biom` to `matrix` type may help.
#' Other packages and R itself handle `matrix` objects naturally, so complete flexibility is then available.
#' (If necessary the transformed matrix can be converted back with `biom(x)`.)
#' However, this conversion discards metadata, which is often important for analysis.
#' So it can be useful (and it's easy) to define your own extensions to `transform.biom()` as illustrated below.
#'
#' For a quick start, a good general recommendation is to work with annotation data normalized as follows.
#' The rest of the tutorial will comprise an explanation of this command and variants.

yy <- transform (xx1, t_Log)		# revise
head(yy)

#' This simpler example is almost self-explanatory.
#' Every entry is changed to its logarithm (after adding one to prevent log of zero).

yy <- transform (xx1, t_Log)

#' `t_NA2Zero` replaces missing values with zero, usually a good idea.
#' `t_Threshold` filters out counts low enough to be considered insignificant.
#' It zeros individual entries below a minimum value, then removes rows summing below a minimum,
#' and then does the same for columns.  By default each threshold is two.

yy <- transform (xx2, t_NA2Zero, t_Threshold, t_Log)
head(yy)

#' The entry, row, and column minimums can be set as follows.
#' This example demonstrates the general syntax for passing arguments to particular transformation functions.

zz <- transform (xx2, t_NA2Zero, t_Threshold=list(entry.min=5, row.min=10, col.min=5), t_Log)

#' A quick check of the annotations discarded by each of the preceding transformations 
#' shows the effect of a more stringent filter:

setdiff (rownames(xx2), rownames(yy))
setdiff (rownames(xx2), rownames(zz))

#' ************************************************
#' each sample centered around zero; scaling columnwise by standard deviation

transform (xx4, t_NA2Zero, t_Threshold, t_Log, t_ColCenter, t_ColScale)

#' ************************************************

#' The transformations described so far are predefined, but it's simple to use your own, too.
#' Any function can be used with `transform.biom()` that expects a matrix `x` as its first argument and returns a modified version of it.
#' The function may drop rows and/or columns, but names of retained rows and columns must also be retained.
#' This example changes all matrix entries to 1 or 0 to indicate presence or absence of an annotation.

t_Indicator <- function (x, ...) { ifelse (x,1,0) }
yy <- transform (xx1, t_Threshold = list(entry.min=10), t_Indicator)
head(yy)

#' Here's a different way to achieve something similar, 
#' illustrating how transformations can accept additional arguments.

t_Indicator <- function (x, min=2, ...) { ifelse (x >= min, 1, 0) }
yy <- transform (xx1, t_Indicator = list(min=10))
head(yy)

