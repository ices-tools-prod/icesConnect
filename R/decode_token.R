#' Decode token
#'
#' Decodes the token to allow inspection of claims
#'
#' @param jwt a javascript web token got by running `ices_token()`
#'
#' @return list of claims
#'
#' @examples
#' \donttest{
#' decode_token()
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
decode_token <- function(jwt = ices_token()) {

  json <-
    rawToChar(
      base64enc::base64decode(
        gsub(".+\\.(.+)\\..+", "\\1", jwt)
      )
    )

  claims <- jsonlite::parse_json(json)

  claims
}
