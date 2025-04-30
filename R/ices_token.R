#' ices_token
#'
#' Stores a user token in the system keyring
#'
#' @param username the ices username that you require a token for,
#'   Default: NULL, which results in \code{getOption("ices.username")}
#' @param password the ices username that you require a token for,
#'   Default: NULL, which results in a dialogue box request for the
#'   password
#' @param refresh should the token be refreshed to update new claims
#'   for example
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
ices_token <- function(username = NULL, password = NULL, refresh = FALSE, ...) {
  if (is.null(username)) {
    username <- get_username()
    if (is.null(username)) {
      warning(
        "Username not set correctly, see ?icesConnect::set_username for more details",
      )
      return(NULL)
    }
  }

  valid_token <- FALSE
  token <- ""
  if (!refresh && has_token(username)) {
    token <- token_get_from_keyring(username)

    # add 10s to system time so we have time to perform the request
    valid_token <- token_expiration(token) > (Sys.time() + 10)
  }

  if (!valid_token) {
    msg <- paste0("Password for (", username, "): ")
    # get a token
    ret <-
      httr::POST(
        "https://taf.ices.dk/api/auth/token",
        body =
          list(
            Username = username,
            Password = if (is.null(password) && interactive()) user_password(msg) else password
          ),
        encode = "json"
      )

    if (httr::status_code(ret) == 200) {
      token_set_from_keyring(httr::content(ret)$token, username)
      token <- token_get_from_keyring(username)
    } else {
      token <- ""
    }
  }

  invisible(token)
}
