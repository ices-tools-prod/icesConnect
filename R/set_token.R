#' Set your ICES token
#'
#' Stores a user token for use in requests to ICES web services that
#' require authentication.
#'
#' Tokens are created at <https://data.ices.dk/token>. Log in, then copy
#' the R code shown on the page into your R session. Tokens can not be
#' refreshed from R: when a token expires, get a new one from the same page.
#'
#' The token is stored in the user configuration directory given by
#' `tools::R_user_dir("icesConnect", "config")`, replacing any token
#' stored previously.
#'
#' @param token character scalar, the token copied from
#'   <https://data.ices.dk/token>
#'
#' @return invisible logical, `TRUE` if the token was stored
#'
#' @seealso [ices_token()] to get the stored token, and [decode_token()] to
#'   see who the token is for and when it expires.
#'
#' @examples
#' \dontrun{
#' set_token("<token copied from https://data.ices.dk/token>")
#' }
#'
#' @rdname set_token
#'
#' @export
set_token <- function(token) {
  if (!is.character(token) || length(token) != 1 || is.na(token)) {
    stop("token should be a single character string", call. = FALSE)
  }
  token <- trimws(token)

  claims <- decode_token(token)
  if (!length(claims)) {
    warning("The token was not stored.", call. = FALSE)
    return(invisible(FALSE))
  }

  if (!isTRUE(claims$expiration > Sys.time())) {
    warning(
      "The token expired on ", format(claims$expiration), " and was not stored.\n",
      "Please get a new token from https://data.ices.dk/token",
      call. = FALSE
    )
    return(invisible(FALSE))
  }

  token_set_from_keyring(token)

  message(
    "Token stored for user: ", claims$user,
    ", expires: ", format(claims$expiration)
  )

  invisible(TRUE)
}
