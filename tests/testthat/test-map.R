test_that("map fails with a data frame or tibble", {
  for_all(
    a = any_tibble(),
    property = \(a) {
      map(identity, a) |> expect_error()
      map(identity, as.data.frame(a)) |> expect_error()
    }
  )
})

test_that("map fails if the functor is atomic and the mapper returns a list", {
  for_all(
    a = any_atomic(),
    property = \(a) map(\(b) list(b), a) |> expect_error()
  )
})

test_that("map doesn't fail with any vector", {
  for_all(
    a = any_vector(len = c(0L, 10L)),
    property = \(a) map(identity, a) |> expect_silent()
  )
})

test_that("map preserves identity", {
  for_all(
    a = any_vector(len = c(0L, 10L)),
    property = \(a) map(identity, a) |> expect_identical(a)
  )
})

test_that("map is composable", {
  for_all(
    a = any_vector(len = c(0L, 10L)),
    property = \(a)
      map(length, map(unique, a)) |>
        expect_identical(map(compose(length, unique), a))
  )
})

test_that("map applies a function to each element", {
  for_all(
    a = integer_(),
    property = \(a) map(\(b) b + 1L, a) |> expect_identical(a + 1L)
  )
})

test_that("map is a curried function", {
  for_all(
    a = any_vector(len = c(0L, 10L)),
    property = \(a)
      map(identity)(a) |> expect_identical(map(identity, a))
  )
})
