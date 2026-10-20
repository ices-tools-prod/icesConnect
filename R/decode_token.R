#' Decode token
#'
#' Decodes the token to allow inspection of claims
#'
#' @param jwt a javascript web token got by running `ices_token()`
#' @param formatted should formatted output be returned
#'
#' @return list of claims, or an empty list if the token is empty or can not
#'   be decoded
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

  if (!length(jwt) || !nzchar(jwt)) {
    return(list())
  }

  claims <-
    tryCatch(
      {
        parts <- strsplit(jwt, ".", fixed = TRUE)[[1]]
        if (length(parts) != 3) {
          stop("a token should have three parts separated by '.'")
        }

        # the payload is base64url encoded: convert to base64 and pad
        payload <- chartr("-_", "+/", parts[2])
        npad <- (4 - nchar(payload) %% 4) %% 4
        payload <- paste0(payload, strrep("=", npad))

        json <- rawToChar(base64enc::base64decode(payload))
        jsonlite::parse_json(json)
      },
      error = function(e) {
        warning(
          "token could not be decoded: ", conditionMessage(e), "\n",
          "Please get a new token from https://data.ices.dk/token",
          call. = FALSE
        )
        NULL
      }
    )

  if (is.null(claims)) {
    return(list())
  }

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
