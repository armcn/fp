#' @export
pipe <- \(...) {
  fs <-
    list(...)

  \(x)
    Reduce(\(acc, .f) .f(acc), fs, x)
}

#' @export
compose <- \(...) {
  do.call(pipe, rev(list(...)))
}

#' @export
`%|>%` <- \(a, .f) {
  .f(a)
}

#' @export
`%.%` <- \(.f, .g) {
  \(a)
    .f(.g(a))
}
