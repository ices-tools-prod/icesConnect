#' @rdname set_username
#'
#' @export
reset_username <- function() {
  if (file.exists(file.path(config_dir(), "username.dcf"))) {
    message("removing username from icesConnect configuration.")
    unlink(
      file.path(config_dir(), "username.dcf")
    )
  }
  else {
    message("no username found in icesConnect configuration.")
  }
}
