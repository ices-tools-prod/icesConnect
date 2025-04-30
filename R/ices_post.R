#' @rdname ices_request_jwt
#' @export
#'
#' @importFrom httr content
ices_post <- function(url, body = list(), retry = TRUE, verbose = FALSE, content = TRUE, use_token = TRUE, encode = "multipart") {
  resp <-
    ices_post_jwt(
      url,
      body,
      encode = encode,
      retry = retry,
      verbose = verbose,
      jwt = if (use_token) NULL else ""
    )

  if (content) {
    content(resp, simplifyVector = TRUE)
  } else {
    resp
  }
}
