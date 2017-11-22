# A .Call function with inbuilt checking for a returned error message.
.hiddenCall <- .Call

#' @useDynLib scaterlegacy, .registration=TRUE
.checkedCall <- function(.NAME, ...) {
    out <- .hiddenCall(.NAME, ...)
    if (is.character(out)) { stop(out) }
    return(out)
}
