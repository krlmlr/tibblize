
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
always return a data frame. This results in a weird behavior of the
reshape function:

``` r
N <- 3
M <- 2

tbl <- tibble::tibble(
  g = gl(N, M),
  time = rep(seq_len(M), N),
  variable = rnorm(M * N)
)

# Current behavior:
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

# Expected result:
reshape(
  as.data.frame(tbl), v.names = "variable",
  idvar = "g", timevar = "time", direction = "wide"
)
#>   g variable.1 variable.2
#> 1 1  0.4255560  1.2046573
#> 3 2 -0.5234699 -0.1084122
#> 5 3  0.2087368  0.2490197
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
#> 1 1  0.4255560  1.2046573
#> 3 2 -0.5234699 -0.1084122
#> 5 3  0.2087368  0.2490197
```

-----

Please note that the ‘tibblizer’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms. \[Copied to clipboard\]
