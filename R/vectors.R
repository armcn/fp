#' @export
map <- curry(\(.f, xs) {
  if (not_fp_functor(xs))
    stop("map only works on atomic vectors or bare lists")

  else if (rlang::is_empty(xs))
    xs

  else if (rlang::is_bare_list(xs))
    lapply(xs, .f)

  else
    map_atomic(.f, xs)
})

map_atomic <- \(.f, xs) {
  new_xs <-
    vctrs::vec_init(.f(xs[1L]), n = length(xs))

  for (i in seq_along(xs)) {
    new_x <-
      .f(xs[i])

    if (is.atomic(new_x))
      new_xs[i] <-
        new_x

    else
      stop("The mapper function must return atomic scalars")
  }

  new_xs
}

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
