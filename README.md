
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fp

# Overview

Functional programming in R.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("armcn/fp")
```

## Usage

### Vector functions

``` r
library(fp, warn.conflicts = FALSE)

numbers <- 1:10
numbers_list <- as.list(numbers)

map(\(a) a * 2, numbers)
#>  [1]  2  4  6  8 10 12 14 16 18 20

map2(`+`, numbers, numbers)
#>  [1]  2  4  6  8 10 12 14 16 18 20

filter(\(a) a > 5, numbers)
#> [1]  6  7  8  9 10

reduce(`+`, 0, numbers)
#> [1] 55

scan(`*`, 1, numbers)
#>  [1]       1       1       2       6      24     120     720    5040   40320
#> [10]  362880 3628800

any(\(a) a %% 2 == 0, numbers)
#> [1] TRUE

all(\(a) a %% 2 == 0, numbers)
#> [1] FALSE

member(5, numbers)
#> [1] TRUE

first(numbers_list)
#> Just
#> [1] 1

last(numbers_list)
#> Just
#> [1] 10

head(numbers_list)
#> Just
#> [[1]]
#> [1] 1

tail(numbers)
#> Just
#> [1]  2  3  4  5  6  7  8  9 10

init(numbers)
#> Just
#> [1] 1 2 3 4 5 6 7 8 9

get_at(3, numbers_list)
#> Just
#> [1] 3
```

### Function composition

``` r
square <- \(a) a ^ 2
is_even <- \(a) a %% 2 == 0
numbers <- 1:10

numbers |> 
  map(square)() |>
  filter(is_even)() |>
  reduce(`+`, 0)()
#> [1] 220

numbers %|>% 
  map(square) %|>% 
  filter(is_even) %|>% 
  reduce(`+`, 0)
#> [1] 220

pipe(
  map(square), 
  filter(is_even), 
  reduce(`+`, 0)
)(numbers)
#> [1] 220

compose(
  reduce(`+`, 0),
  filter(is_even),
  map(square)
)(numbers)
#> [1] 220

sum_even_squares <- 
  reduce(`+`, 0) %.% 
  filter(is_even) %.%
  map(square)

sum_even_squares(numbers)
#> [1] 220
```
