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
    username <- getOption("icesTAFWeb.username")
    if (is.null(username)) {
      # NULL means use system username
      username <- whoami::username()
      not.usermessaged <-
        is.null(getOption("ices.usermessaged")) ||
          !getOption("ices.usermessaged")
      if (not.usermessaged) {
        options(ices.usermessaged = TRUE)
        ## message to user about adding username to options
        message(
          "using system username: ", username,
          "\nConsider adding a default username using:\n\ticesConnect::set_username(<add username here>)"
        )
      }
    }
  }

  valid_token <- FALSE
  token <- ""
  if (has_token(username)) {
    usernames <- grep(paste0(username, "_[0-9]+"), keyring::key_list()$username, value = TRUE)
    token <- paste(sapply(usernames, keyring::key_get, service = "ices_token"), collapse = "")

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

      tokens <- httr::content(ret)$token
      if (nchar(tokens) > 2500) {
        tokens <-
          substring(
            tokens,
            seq(1, nchar(tokens), by = 2500),
            seq(1, nchar(tokens), by = 2500) - 1 + 2500
          )
      }

      for (i in seq_along(tokens)) {
        # set token in keyring
        keyring::key_set_with_value(
          service = "ices_token",
          username = paste0(username, "_", i),
          password = tokens[i]
        )
      }

      usernames <- grep(paste0(username, "_[0-9]+"), keyring::key_list()$username, value = TRUE)
      token <- paste(sapply(usernames, keyring::key_get, service = "ices_token"), collapse = "")
    }
  }

  invisible(token)
}
