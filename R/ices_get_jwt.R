#' ices_get_jwt
#'
#' Perform a get request to a url using a javascript web token for authentication
#'
#' @param url PARAM_DESCRIPTION
#' @param retry PARAM_DESCRIPTION, Default: TRUE
#' @param quiet should the request be made queitly
#'
#' @return httr response object
#'
#' @examples
#' ices_get_jwt("https://taf.ices.dk/vms/api/gearwidths")
#'
#' @seealso
#'  \code{\link[icesConnect]{ices_token}}
#'  \code{\link[httr]{GET}},\code{\link[httr]{add_headers}},\code{\link[httr]{stop_for_status}},\code{\link[httr]{status_code}}
#' @rdname ices_get_jwt
#'
#' @importFrom httr GET add_headers message_for_status status_code stop_for_status
#'
#' @export

ices_get_jwt <- function(url, retry = TRUE, quiet = FALSE) {

  jwt <- ices_token()
  out <-
    if (nzchar(jwt)) {
      httr::GET(
        url,
        httr::add_headers(Authorization = paste("Bearer", jwt))
      )
    } else {
      httr::GET(url)
    }

  if (!quiet) {
    httr::message_for_status(out)
    message("\n")
  }

  if (httr::status_code(out) == 404 & retry) {
    # try again - sometimes the server seems to return 404 on the
    # first request
    message("Server not responding, doing one retry.")
    ices_get_jwt(url, retry = FALSE)
  }

  msg_401 <-
    paste0(
      ": You don't have access to this resource.\n",
      "Invalid or missing token. Please run:\n",
      "    icesConnect::ices_token()\n",
      "to create your personal access token.\n"
    )

  msg_403 <-
    paste0(
      ": You don't have access to this resource. Please run:\n",
      "    icesConnect::ices_token()\n",
      "to create or update your personal access token.\n"
    )

  tryCatch(httr::stop_for_status(out),
    http_404 = function(c) message(": Url doesn't exist - the server may not responding."),
    http_403 = function(c) message(msg_403),
    http_401 = function(c) message(msg_401),
    http_400 = function(c) message(": Check function arguments, probably a user error."),
    http_500 = function(c) message(": Something went wrong on the server :(")
  )

  return(out)
}
