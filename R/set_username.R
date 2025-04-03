#' Set your ICES username
#'
#' Set the ICES user or logon name that will be used for requests
#'
#' @param username the ices username you use to login to SharePoint
#'   for example.
#'
#' @return invisible value: the previous username that was set
#'
#' @examples
#' \dontrun{
#' set_username("myusername")
#' }
#'
#' @rdname set_username
#'
#' @export
set_username <- function(username) {
  write.dcf(
    list(username = username),
    file.path(config_dir(), "username.dcf")
  )
}
