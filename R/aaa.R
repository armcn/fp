curry_2 <- function(fn) {
  \(a, b)
    switch(nargs(),
      "1" = \(.b) fn(a, .b),
      "2" = fn(a, b)
    )
}

curry_3 <- function(fn) {
  \(a, b, c)
    switch(nargs(),
      "1" = curry_2(\(.b, .c) fn(a, .b, .c)),
      "2" = \(.c) fn(a, b, .c),
      "3" = fn(a, b, c)
    )
}

curry_4 <- function(fn) {
  \(a, b, c, d)
    switch(nargs(),
      "1" = curry_3(\(.b, .c, .d) fn(a, .b, .c, .d)),
      "2" = curry_2(\(.c, .d) fn(a, b, .c, .d)),
      "3" = \(.d) fn(a, b, c, .d),
      "4" = fn(a, b, c, d)
    )
}

curry_5 <- function(fn) {
  \(a, b, c, d, e)
    switch(nargs(),
      "1" = curry_4(\(.b, .c, .d, .e) fn(a, .b, .c, .d, .e)),
      "2" = curry_3(\(.c, .d, .e) fn(a, b, .c, .d, .e)),
      "3" = curry_2(\(.d, .e) fn(a, b, c, .d, .e)),
      "4" = \(.e) fn(a, b, c, d, .e),
      "5" = fn(a, b, c, d, e)
    )
}

curry <- function(fn) {
  curry_n(length(formals(args(fn))), fn)
}

curry_n <- function(n, fn) {
  switch(n,
    "1" = fn,
    "2" = curry_2(fn),
    "3" = curry_3(fn),
    "4" = curry_4(fn),
    "5" = curry_5(fn),
    stop("functions can't be curried with > 5 arguments")
  )
}
