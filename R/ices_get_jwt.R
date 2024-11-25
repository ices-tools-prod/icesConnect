#' @rdname ices_request_jwt
#' @export
ices_get_jwt <- function(url,
                         username = NULL,
                         retry = TRUE, quiet = FALSE,
                         verbose = FALSE,
                         jwt = NULL) {
  out <-
    ices_request_jwt(
      "GET", url,
      body = NULL, encode = "json", username = username,
      retry = retry, quiet = quiet, verbose = verbose,
      jwt = jwt
    )

  return(out)
}
