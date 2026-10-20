#' ices_token
#'
#' Returns the user token stored by [set_token()], if it is present and has
#' not expired.
#'
#' Tokens are created at <https://data.ices.dk/token>. Log in, then copy
#' the R code shown on the page into your R session to store the token.
#' Tokens can not be refreshed from R: when a token expires, get a new one
#' from the same page.
#'
#' @param ... not used, only here for back compatibility
#'
#' @return character scalar, the token, or `""` if there is no valid token
#'
#' @seealso [set_token()] to store a token.
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

  token <- ""
  if (has_token()) {
    token <-
      tryCatch(
        token_get_from_keyring(),
        error = function(e) ""
      )
  }

  if (!nzchar(token)) {
    warning(
      "No token found. Please log in at https://data.ices.dk/token\n",
      "and run the R code shown there to set your token.",
      call. = FALSE
    )
    return(invisible(""))
  }

  expiration <- token_expiration(token)

  # add 10s to system time so we have time to perform the request
  if (!isTRUE(expiration > (Sys.time() + 10))) {
    if (length(expiration)) {
      warning(
        "Your token expired on ", format(expiration), ". Please log in at\n",
        "https://data.ices.dk/token and run the R code shown there to\n",
        "set a new token.",
        call. = FALSE
      )
    }
    token <- ""
  }

  invisible(token)
}
