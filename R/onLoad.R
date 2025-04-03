.onLoad <- function(libname, pkgname) {

  # default package options
  username <- suppressMessages(get_username())
  if (is.null(username)) {
    packageStartupMessage("icesConnect running as anonymous user, set your ICES username using:\n\ticesConnect::set_username(<add username here>)")
  } else {
    packageStartupMessage("icesConnect running as ICES user: ", username)
  }

  invisible()
}
