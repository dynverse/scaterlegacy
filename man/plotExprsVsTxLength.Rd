% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting.R
\name{plotExprsVsTxLength}
\alias{plotExprsVsTxLength}
\title{Plot expression against transcript length}
\usage{
plotExprsVsTxLength(object, tx_length = "median_feat_eff_len",
  exprs_values = "exprs", colour_by = NULL, shape_by = NULL,
  size_by = NULL, xlab = NULL, show_exprs_sd = FALSE,
  show_smooth = FALSE, alpha = 0.6, theme_size = 10,
  log2_values = FALSE, size = NULL, se = TRUE)
}
\arguments{
\item{object}{an \code{\link{SCESet}} object}

\item{tx_length}{transcript lengths to plot on the x-axis. Can be one of: (1)
the name of a column of \code{fData(object)} containing the transcript length
values, or (2) the name of an element of \code{assayData(object)} containing
a matrix of transcript length values, or (3) a numeric vector of length equal
to the number of rows of \code{object} (number of features).}

\item{exprs_values}{character string indicating which values should be used
as the expression values for this plot. Valid arguments are \code{"tpm"}
(transcripts per million), \code{"norm_tpm"} (normalised TPM
values), \code{"fpkm"} (FPKM values), \code{"norm_fpkm"} (normalised FPKM
values), \code{"counts"} (counts for each feature), \code{"norm_counts"},
\code{"cpm"} (counts-per-million), \code{"norm_cpm"} (normalised
counts-per-million), \code{"exprs"} (whatever is in the \code{'exprs'} slot
of the \code{SCESet} object; default), \code{"norm_exprs"} (normalised
expression values) or \code{"stand_exprs"} (standardised expression values)
or any other slots that have been added to the \code{"assayData"} slot by
the user.}

\item{colour_by}{optional character string supplying name of a column of
\code{fData(object)} which will be used as a variable by which to colour
expression values on the plot. Alternatively, a data frame with
one column, containing a value for each feature to map to a colour.}

\item{shape_by}{optional character string supplying name of a column of
\code{fData(object)} which will be used as a variable to define the shape of
points for expression values on the plot. Alternatively, a data frame
with one column containing values to map to shapes.}

\item{size_by}{optional character string supplying name of a column of
\code{fData(object)} which will be used as a variable to define the size of
points for expression values on the plot. Alternatively, a data frame
with one column containing values to map to sizes.}

\item{xlab}{label for x-axis; if \code{NULL} (default), then \code{x} will be
used as the x-axis label}

\item{show_exprs_sd}{logical, show the standard deviation of expression
values for each feature on the plot}

\item{show_smooth}{logical, show a smoothed fit through the expression values
on the plot}

\item{alpha}{numeric value between 0 (completely transparent) and 1 (completely
solid) defining how transparent plotted points (cells) should be.
Points are jittered horizontally if the x-axis value is categorical rather
than numeric to avoid overplotting.}

\item{theme_size}{numeric scalar giving default font size for plotting theme
(default is 10)}

\item{log2_values}{should the expression values be transformed to the
log2-scale for plotting (with an offset of 1 to avoid logging zeroes)?}

\item{size}{numeric scalar optionally providing size for points if
\code{size_by} argument is not given. Default is \code{NULL}, in which case
\pkg{ggplot2} default is used.}

\item{se}{logical, should standard errors be shown (default \code{TRUE}) for
the smoothed fit through the cells. (Ignored if \code{show_smooth} is \code{FALSE}).}
}
\value{
a ggplot object
}
\description{
Plot expression values from an SCESet object against transcript length values
defined in the SCESet object or supplied as an argument.
}
\examples{
data("sc_example_counts")
data("sc_example_cell_info")
pd <- new("AnnotatedDataFrame", data = sc_example_cell_info)
fd <- new("AnnotatedDataFrame", data =
data.frame(gene_id = rownames(sc_example_counts),
        feature_id = paste("feature", rep(1:500, each = 4), sep = "_"),
     median_tx_length = rnorm(2000, mean = 5000, sd = 500)))
rownames(fd) <- rownames(sc_example_counts)
example_sceset <- newSCESet(countData = sc_example_counts, phenoData = pd,
featureData = fd)

plotExprsVsTxLength(example_sceset, "median_tx_length")
plotExprsVsTxLength(example_sceset, "median_tx_length", show_smooth = TRUE)
plotExprsVsTxLength(example_sceset, "median_tx_length", show_smooth = TRUE,
show_exprs_sd = TRUE)

## using matrix of tx length values in assayData(object)
mat <- matrix(rnorm(ncol(example_sceset) * nrow(example_sceset), mean = 5000,
 sd = 500), nrow = nrow(example_sceset))
dimnames(mat) <- dimnames(example_sceset)
set_exprs(example_sceset, "tx_len") <- mat

plotExprsVsTxLength(example_sceset, "tx_len", show_smooth = TRUE,
show_exprs_sd = TRUE)

## using a vector of tx length values
plotExprsVsTxLength(example_sceset, rnorm(2000, mean = 5000, sd = 500))

}
