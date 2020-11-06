#' ices_token
#'
#' Stores a user token in the system keyring
#'
#' @param username the ices username that you require a token for,
#'   Default: getOption("ices.username")
#' @param ... not yet used
#'
#' @return character scalar, the token
#'
#' @examples
#' \dontrun{
#' ices_token()
#' }
#'
#' @seealso
#'  \code{\link[whoami]{username}}
#'  \code{\link[keyring]{key_get}}
#'
#' @rdname ices_token
#'
#' @importFrom whoami username
#' @importFrom keyring key_get key_set_with_value
#'
#' @export
ices_token <- function(username = getOption("ices.username"), ...) {

  if (is.null(username)) {
    # NULL means use system username
    username <- whoami::username()
  }

  valid_token <- FALSE
  token <- ""
  if (has_token(username)) {
    token <- keyring::key_get("ices_token", username)

    # add 10s to system time so we have time to perform the request
    valid_token <- token_expiration(token) > (Sys.time() + 10)
  }

  if (!valid_token) {
    msg <- paste0("Password for (", username, "): ")
    # get a token
    ret <-
      httr::POST(
        "https://taf.ices.dk/github/auth/token",
        body = list(Username = username, Password = user_password(msg)),
        encode = "json"
      )

    if (httr::status_code(ret) == 200) {

      # set token in keyring
      keyring::key_set_with_value(
        service = "ices_token",
        username = username,
        password = httr::content(ret)$token
      )

      token <- keyring::key_get("ices_token", username)
    }
  }

  invisible(token)
}
