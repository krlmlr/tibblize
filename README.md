
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tibblizer

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/tibblizer)](https://CRAN.R-project.org/package=tibblizer)
<!-- badges: end -->

The goal of tibblizer is to make it easier to support tibbles in
functions that are not currently designed to support them.

## Installation

You can install the released version of tibblizer from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("tibblizer")
```

## Example

The `stats::reshape()` function assumes that `x[i, j]` returns a vector
if `j` refers to a single columns. Tibbles never drop dimensions and
always return a data frame.

``` r
N <- 3
M <- 2

tbl <- tibble::tibble(
  g = gl(N, M),
  time = rep(seq_len(M), N),
  variable = rnorm(M * N)
)

reshape(
  tbl, v.names = "variable",
  idvar = "g", timevar = "time", direction = "wide"
)
#> # A tibble: 3 x 2
#>   g     `variable.1:2`
#>   <fct>          <dbl>
#> 1 1                 NA
#> 2 2                 NA
#> 3 3                 NA
```

tibblizer to the rescue: Use `tbl_()` to create a tibble-friendly
version of the `reshape()` function:

``` r
library(tibblizer)

reshape <- tbl_(reshape)

reshape(
  tbl, v.names = "variable",
  idvar = "g", timevar = "time", direction = "wide"
)
#>   g variable.1 variable.2
#> 1 1  0.4524000  0.4105407
#> 3 2  0.8823839 -0.6568657
#> 5 3  0.3297717  1.7623047
```

-----

Please note that the ‘tibblizer’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms. \[Copied to clipboard\]
