#' ices_token
#'
#' Stores a user token in the system keyring
#'
#' @param ... not yet used
#'
#' @return character scalar, the token
#'
#' @examples
#' \dontrun{
#' ices_token()
#' }
#'
#' @rdname ices_token
#'
#' @export
ices_token <- function(...) {

  valid_token <- FALSE
  token <- ""
  if (has_token()) {
    token <- token_get_from_keyring()

    # add 10s to system time so we have time to perform the request
    valid_token <- token_expiration(token) > (Sys.time() + 10)
  }

  if (!valid_token) {
    warning("No token found, Please go to: https://data.ices.dk/token to get your token.")
    token <- ""
  }

  invisible(token)
}
