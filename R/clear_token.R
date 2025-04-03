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
#'
#' @rdname clear_token
#'
#'
#' @export
clear_token <- function(username = get_username()) {
  if (is.null(username)) {
    return (NULL)
  }

  user_files <- list.files(config_dir(), full.names = TRUE)

  unlink(user_files[grep(paste0(username, ".dcf"), user_files)])
}
