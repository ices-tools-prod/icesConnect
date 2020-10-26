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

  # get token
  token <- try(
    keyring::key_get("ices_token", username),
    silent = TRUE
  )

  if (inherits(token, "try-error")) {
    # get a token
    ret <-
      httr::POST(
        "https://taf.ices.dk/github/auth/token",
        body = list(Username = username, Password = "Pompei#Febbraio2020"),
        encode = "json"
      )

    # set token in keyring
    keyring::key_set_with_value(
      service = "ices_token",
      username = username,
      password = httr::content(ret)$token
    )

    token <- keyring::key_get("ices_token", username)
  }

  invisible(token)
}
