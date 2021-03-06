% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/qc.R
\docType{methods}
\name{plotRLE}
\alias{plotRLE}
\alias{plotRLE}
\alias{plotRLE,SCESet-method}
\title{Plot a relative log expression (RLE) plot}
\usage{
plotRLE(object, ...)

\S4method{plotRLE}{SCESet}(object, exprs_mats = list(exprs = "exprs"),
  exprs_logged = c(TRUE), colour_by = NULL, style = "minimal",
  legend = "auto", order_by_colour = TRUE, ncol = 1, ...)
}
\arguments{
\item{object}{an \code{SCESet} object}

\item{...}{further arguments passed to \code{\link[ggplot2]{geom_boxplot}}.}

\item{exprs_mats}{named list of expression matrices. Entries can either be a
character string, in which case the corresponding expression matrix will be
extracted from the SCESet \code{object}, or a matrix of expression values.}

\item{exprs_logged}{logical vector of same length as \code{exprs_mats} indicating
whether the corresponding entry in \code{exprs_mats} contains logged expression
values (\code{TRUE}) or not (\code{FALSE}).}

\item{colour_by}{character string defining the column of \code{pData(object)} to
be used as a factor by which to colour the points in the plot. Alternatively,
a data frame with one column, containing values to map to colours for all cells.}

\item{style}{character(1), either \code{"minimal"} (default) or \code{"full"},
defining the boxplot style to use. \code{"minimal"} uses Tufte-style boxplots and
is fast for large numbers of cells. \code{"full"} uses the usual
\code{\link{ggplot2}} and is more detailed and flexible, but can take a long
time to plot for large datasets.}

\item{legend}{character, specifying how the legend(s) be shown? Default is
\code{"auto"}, which hides legends that have only one level and shows others.
Alternative is "none" (hide all legends).}

\item{order_by_colour}{logical, should cells be ordered (grouped) by the
\code{colour_by} variable? Default is \code{TRUE}. Useful for visualising
differences between batches or experimental conditions.}

\item{ncol}{integer, number of columns for the facetting of the plot.
Default is 1.}
}
\value{
a ggplot plot object
}
\description{
Produce a relative log expression (RLE) plot of one or more transformations of
cell expression values.
}
\details{
Unwanted variation can be highly problematic and so its detection is often crucial.
Relative log expression (RLE) plots are a powerful tool for visualising such
variation in high dimensional data. RLE plots are particularly useful for
assessing whether a procedure aimed at removing unwanted variation, i.e. a
normalisation procedure, has been successful. These plots, while originally
devised for gene expression data from microarrays, can also be used to reveal
unwanted variation in single-cell expression data, where such variation can be
problematic.

If style is "full", as usual with boxplots, the box shows the inter-quartile
range and whiskers extend no more than 1.5 * IQR from the hinge (the 25th or
75th percentile). Data beyond the whiskers are called outliers and are plotted
individually. The median (50th percentile) is shown with a white bar.

If style is "minimal", then median is shown with a circle, the IQR in a grey
line, and "whiskers" (as defined above) for the plots are shown with coloured
lines. No outliers are shown for this plot style.
}
\examples{
data("sc_example_counts")
data("sc_example_cell_info")
pd <- new("AnnotatedDataFrame", data = sc_example_cell_info)
example_sceset <- newSCESet(countData = sc_example_counts, phenoData = pd)
drop_genes <- apply(exprs(example_sceset), 1, function(x) {var(x) == 0})
example_sceset <- example_sceset[!drop_genes, ]

plotRLE(example_sceset, list(exprs = "exprs", counts = "counts"), c(TRUE, FALSE),
       colour_by = "Mutation_Status", style = "minimal")

plotRLE(example_sceset, list(exprs = "exprs", counts = "counts"), c(TRUE, FALSE),
       colour_by = "Mutation_Status", style = "full",
       outlier.alpha = 0.1, outlier.shape = 3, outlier.size = 0)

}
\references{
Gandolfo LC, Speed TP. RLE Plots: Visualising Unwanted Variation in High Dimensional Data.
arXiv [stat.ME]. 2017. Available: http://arxiv.org/abs/1704.03590
}
\author{
Davis McCarthy
}
