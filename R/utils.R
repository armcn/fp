res_vec <- \(xs) {
  if (is.atomic(xs))
    vector("logical", length(xs))

  else
    vector("list", length(xs))
}
