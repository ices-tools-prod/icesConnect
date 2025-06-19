.onAttach <- function(libname, pkgname) {

  # default package options
  user <-
    suppressMessages(
      suppressWarnings(
        token_user()
      )
    )

  if (is.null(user)) {
    packageStartupMessage("icesConnect running with no token.")
  } else {
    packageStartupMessage("icesConnect running as: ", user)
  }

  invisible()
}
