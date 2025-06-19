#' @rdname ices_request_jwt
#' @export
ices_post_jwt <- function(url, body = list(), encode = "json",
                          retry = TRUE, quiet = FALSE,
                          verbose = FALSE,
                          jwt = NULL) {
  out <-
    ices_request_jwt(
      "POST", url,
      body = body, encode = encode,
      retry = retry, quiet = quiet, verbose = verbose,
      jwt = jwt
    )

  return(out)
}
