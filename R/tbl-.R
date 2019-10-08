#' Wrap a function to support tibbles
#'
#' Use this to make functions that only accept bare data frames
#' also accept tibbles.
#' This is a function constructor: it wraps a user-supplied function with logic
#' that converts inputs from tibbles to data frames.
#'
#' @export
#' @examples
#' N <- 3
#' M <- 2
#'
#' tbl <- tibble::tibble(
#'   g = gl(N, M),
#'   time = rep(seq_len(M), N),
#'   variable = rnorm(M * N)
#' )
#'
#' try(reshape(
#'   tbl, v.names = "variable",
#'   idvar = "g", timevar = "time", direction = "wide"
#' ))
#'
#' tbl_(reshape)(
#'   tbl, v.names = "variable",
#'   idvar = "g", timevar = "time", direction = "wide"
#' )
tbl_ <- function(f, args = NULL) {
  force(f)
  stopifnot(is.function(f))
  args <- enquo(args)

  if (quo_is_null(args)) {
    args <- names(formals(f))
  } else {
    stop("NYI")
  }

  wrapper <- function(...) {
    args <- lapply(list(...), to_data_frame)

    eval_tidy(quo(f(!!!args)))
  }
}

to_data_frame <- function(x) {
  if (is_tibble(x)) x <- as.data.frame(x)
  x
}
