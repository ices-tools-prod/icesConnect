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
decode_token <- function(jwt = ices_token(), formatted = TRUE) {

  json <-
    rawToChar(
      base64enc::base64decode(
        gsub(".+\\.(.+)\\..+", "\\1", jwt)
      )
    )

  claims <- jsonlite::parse_json(json)

  if (formatted) {
    claims <-
      list(
        sharepoint = gsub("SP_", "", grep("SP_", names(claims), value = TRUE)),
        github = gsub("GH_", "", grep("GH_", names(claims), value = TRUE)),
        username = claims$sub,
        email = claims$`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`,
        github_username = claims$GitHubUserName,
        expiration = as.POSIXct(claims$exp, origin = "1970-01-01")
      )
  }

  claims
}
