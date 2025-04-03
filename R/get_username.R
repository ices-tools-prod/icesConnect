
#' get_username
#'
#' Get your ICES username from the options.
#'
#' @return character scalar, the username
#'
#' @examples
#' \dontrun{
#' get_username()
#' }
#'
#' @rdname set_username
#'
#' @export
get_username <- function() {
  username <- NULL
  if (file.exists(file.path(config_dir(), "username.dcf"))) {
    username <-
      read.dcf(
        file.path(config_dir(), "username.dcf")
      )[,"username"]
  }

  if (is.null(username)) {
    ## message to user about adding username to options
    message(
      "Set your ICES username using:\n\ticesConnect::set_username(<add username here>)"
    )
  }

  unname(username)
}
