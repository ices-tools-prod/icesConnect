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
#' ices_cleartoken()
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

  keyring::key_delete("ices_token", username = username)
}
