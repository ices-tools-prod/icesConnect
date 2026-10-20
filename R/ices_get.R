#' @rdname ices_request_jwt
#' @export
#'
#' @importFrom httr content http_error
ices_get <- function(url, retry = TRUE, quiet = FALSE, verbose = FALSE,
  content = TRUE, use_token = FALSE, jwt = NULL) {
  resp <-
    ices_get_jwt(
      url,
      retry = retry, quiet = quiet, verbose = verbose,
      jwt = if (use_token) jwt else ""
    )

  if (content) {
    response_content(resp)
  } else {
    resp
  }
}

# parse the content of a response, returning NULL if the request failed,
# rather than trying to parse an error page or an empty response
response_content <- function(resp) {
  if (is.null(resp) || http_error(resp)) {
    return(NULL)
  }

  content(resp, simplifyVector = TRUE)
}
