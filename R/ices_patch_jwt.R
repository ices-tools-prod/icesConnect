#' @rdname ices_request_jwt
#' @export
ices_patch_jwt <- function(url, body = list(), encode = "json",
                           username = NULL,
                           retry = TRUE, quiet = FALSE,
                           verbose = FALSE,
                           jwt = NULL) {
  out <-
    ices_request_jwt(
      "PATCH", url,
      body = body, encode = encode, username = username,
      retry = retry, quiet = quiet, verbose = verbose,
      jwt = jwt
    )

  return(out)
}
