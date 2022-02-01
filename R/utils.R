res_vec <- \(xs) {
  if (is.atomic(xs))
    vector("logical", length(xs))

  else
    vector("list", length(xs))
}

is_fp_functor <- \(xs) {
  rlang::is_atomic(xs) || rlang::is_bare_list(xs)
}

not_fp_functor <- \(xs) {
  Negate(is_fp_functor)(xs)
}
