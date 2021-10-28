#' Token expiration
#'
#' Return the expiration date of the token
#'
#' @param jwt a javascript web token got by running `ices_token()`
#'
#' @return POSIXct date time
#'
#' @examples
#' \dontrun{
#' token_expiration()
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
token_expiration <- function(jwt = ices_token()) {
  claims <- decode_token(jwt)

  as.POSIXct(claims$exp, origin = "1970-01-01")
}
