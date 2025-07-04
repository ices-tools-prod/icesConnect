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
#' @rdname decode_token
#'
#' @importFrom base64enc base64decode
#' @importFrom jsonlite parse_json
#'
#' @export
token_expiration <- function(jwt = ices_token()) {
  claims <- decode_token(jwt)

  claims$expiration
}
