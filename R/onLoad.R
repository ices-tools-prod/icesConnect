.onLoad <- function(libname, pkgname) {

  # default package options
  opts <-
    c(
      "ices.username" = "NULL"
    )
  # set only those not previouslyt set
  for (i in setdiff(names(opts), names(options()))) {
    eval(parse(text = paste0("options(", i, "=", opts[i], ")")))
  }

  invisible()
}
