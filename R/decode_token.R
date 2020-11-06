
#' @importFrom base64enc base64decode
#' @importFrom jsonlite parse_json

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
