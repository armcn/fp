#' @export
map <- curry(\(.f, xs) {
  vec <-
    res_vec(xs)

  for (i in seq_along(xs))
    vec[[i]] <-
      .f(xs[[i]])

  vec
})

#' @export
map2 <- curry(\(.f, xs, ys) {
  vec <-
    if (length(xs) > length(ys))
      res_vec(ys)

    else
      res_vec(xs)

  for (i in seq_along(vec))
    vec[[i]] <-
      .f(xs[[i]], ys[[i]])

  vec
})

#' @export
filter <- curry(\(.f, xs) {
  if (is.atomic(xs))
    xs[map(.f, xs)]

  else
    Filter(.f, xs)
})

#' @export
reduce <- curry(\(.f, .init, xs) {
  Reduce(.f, xs, .init)
})

#' @export
scan <- curry(\(.f, .init, xs) {
  Reduce(.f, xs, .init, accumulate = TRUE)
})

#' @export
any <- curry(\(.f, xs) {
  for (i in seq_along(xs))
    if (isTRUE(.f(xs[[i]])))
      return(TRUE)

  FALSE
})

#' @export
all <- curry(\(.f, xs) {
  for (i in seq_along(xs))
    if (!isTRUE(.f(xs[[i]])))
      return(FALSE)

  TRUE
})

#' @export
member <- curry(\(x, xs) {
  isTRUE(x %in% xs)
})

#' @export
first <- \(xs) {
  if (length(xs) == 0L)
    maybe::nothing()

  else
    maybe::just(xs[[1L]])
}

#' @export
last <- \(xs) {
  if (length(xs) == 0L)
    maybe::nothing()

  else
    maybe::just(xs[[length(xs)]])
}

#' @export
head <- \(xs) {
  if (length(xs) == 0L)
    maybe::nothing()

  else
    maybe::just(xs[1L])
}

#' @export
tail <- \(xs) {
  if (length(xs) == 0L)
    maybe::nothing()

  else
    maybe::just(xs[-1L])
}

#' @export
init <- \(xs) {
  if (length(xs) == 0L)
    maybe::nothing()

  else
    maybe::just(xs[-length(xs)])
}

#' @export
get_at <- curry(\(i, xs) {
  if (i <= 1 || i > length(xs))
    maybe::nothing()

  else
    maybe::just(xs[[i]])
})
