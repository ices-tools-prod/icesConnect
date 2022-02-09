#' Return username for a token
#'
#' What user is this token for
#'
#' @param jwt a javascript web token got by running `ices_token()`
#'
#' @return string, user name
#'
#' @examples
#' \dontrun{
#' token_user()
#' }
#'
#' @seealso
#'  \code{\link[whoami]{username}}
#'  \code{\link[keyring]{key_get}}
#'
#' @rdname decode_token
#'
#' @importFrom base64enc base64decode
#' @importFrom jsonlite parse_json
#'
#' @export
token_user <- function(jwt = ices_token()) {
  claims <- decode_token(jwt)
  claims$username
}
