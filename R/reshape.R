#' @export
stats::reshape

#' @export
reshape <- function(data, ...) {
  UseMethod("reshape")
}

#' @export
reshape.default <- function(data, ...) {
  stats::reshape(data, ...)
}

#' @export
reshape.tbl_df <- function(data, ...) {
  data <- as.data.frame(data)
  as_tibble(NextMethod(data = data))
}
