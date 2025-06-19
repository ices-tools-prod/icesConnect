#' Decode token
#'
#' Decodes the token to allow inspection of claims
#'
#' @param jwt a javascript web token got by running `ices_token()`
#' @param formatted should formatted output be returned
#'
#' @return list of claims
#'
#' @examples
#' \dontrun{
#' decode_token()
#' }
#'
#' @rdname decode_token
#'
#' @importFrom base64enc base64decode
#' @importFrom jsonlite parse_json
#'
#' @export
decode_token <- function(jwt = ices_token(), formatted = TRUE) {

  if (jwt == "") {
    return(list())
  }

  json <-
    rawToChar(
      base64enc::base64decode(
        gsub(".+\\.(.+)\\..+", "\\1", jwt)
      )
    )

  claims <- jsonlite::parse_json(json)

  if (formatted) {
    expiration <- as.POSIXct(claims$exp, origin = "1970-01-01")
    time_diff <- difftime(expiration, Sys.time(), units = "days")

    claims <-
      list(
        user = claims$Email,
        expiration = expiration,
        time_to_expiration = round(time_diff, 2)
      )
  }

  claims
}
