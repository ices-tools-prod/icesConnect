#' Decode token
#'
#' Decodes the token to allow inspection of claims
#'
#' @param jwt a javascript web token got by running `ices_token()`
#'
#' @return list of claims
#'
#' @examples
#' \dontrun{
#' jwt <- ices_token()
#' decode_token(jwt)
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


decode_token <- function(jwt) {

  json <-
    rawToChar(
      base64enc::base64decode(
        gsub(".+\\.(.+)\\..+", "\\1", jwt)
      )
    )

  claims <- jsonlite::parse_json(json)

  claims
}

token_expiration <- function(jwt) {
  claims <- decode_token(jwt)

  as.POSIXct(claims$exp, origin = "1970-01-01")
}

token_user <- function(jwt) {
  claims <- decode_token(jwt)
  claims$sub
}
