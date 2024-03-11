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
#'
#' @rdname clear_token
#'
#' @importFrom whoami username
#'
#' @export
clear_token <- function(username = getOption("ices.username")) {
  if (is.null(username)) {
    # NULL means use system username
    username <- whoami::username()
  }

  user_files <- list.files(config_dir(), full.names = TRUE)

  unlink(user_files[grep(paste0(username, ".dcf"), user_files)])
}
