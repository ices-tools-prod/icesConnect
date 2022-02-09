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
#' \donttest{
#' set_username("myusername")
#' }
#'
#' @details
#'
#' To set this permanently, add the line:
#' \code{options(ices.username = "your ices user name")}
#' to your RProfile file, see, usually '~/.Rprofile', see
#' \code{\link[base]{Startup}} for more information.
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
