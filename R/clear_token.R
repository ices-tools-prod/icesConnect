#' clear_token
#'
#' Deletes the token from the key ring.
#'
#' @param username the ices username that you require a token for,
#'   Default: getOption("ices.username")
#'
#' @return no return value
#'
#' @examples
#' \dontrun{
#' clear_token()
#' }
#'
#' @seealso
#'  \code{\link[whoami]{username}}
#'  \code{\link[keyring]{key_get}}
#'
#' @rdname clear_token
#'
#' @importFrom whoami username
#' @importFrom keyring key_delete
#'
#' @export
clear_token <- function(username = getOption("ices.username")) {
  if (is.null(username)) {
    # NULL means use system username
    username <- whoami::username()
  }

  usernames <-
    grep(
      paste0(username, "_[0-9]+"), keyring::key_list()$username,
      value = TRUE
    )

  for (i in seq_along(usernames)) {
    keyring::key_delete("ices_token", username = usernames[i])
  }

}
