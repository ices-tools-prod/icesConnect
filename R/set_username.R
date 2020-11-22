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
#' ices_token()
#' }
#'
#' @seealso
#'  \code{\link[base]{options}}
#'  \code{\link[base]{getOption}}
#'
#' @rdname set_username
#'
#' @export
set_username <- function(username) {
  options(ices.username = username)
}
