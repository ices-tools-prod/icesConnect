#' @rdname ices_request_jwt
#' @export
#'
#' @importFrom httr content
ices_get <- function(url, retry = TRUE, quiet = FALSE, verbose = FALSE,
  content = TRUE, use_token = FALSE, jwt = NULL) {
  resp <-
    ices_get_jwt(
      url,
      retry = retry, quiet = quiet, verbose = verbose,
      jwt = if (use_token) jwt else ""
    )

  if (content && !is.null(resp)) {
    content(resp, simplifyVector = TRUE)
  } else {
    resp
  }
}
