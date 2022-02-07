#' @rdname ices_request_jwt
#' @export
ices_get_jwt <- function(url,
                          username = NULL,
                          retry = TRUE, quiet = FALSE,
                          verbose = FALSE) {

  out <-
    ices_request_jwt(
      "GET", url,
      body = NULL, encode = "json", username = username,
      retry = retry, quiet = quiet, verbose = verbose
    )

  return(out)
}

#' @rdname ices_request_jwt
#' @export
ices_post_jwt <- function(url, body = list(), encode = "json",
                          username = NULL,
                          retry = TRUE, quiet = FALSE,
                          verbose = FALSE) {
  out <-
    ices_request_jwt(
      "POST", url,
      body = body, encode = encode, username = username,
      retry = retry, quiet = quiet, verbose = verbose
    )

  return(out)
}

#' @rdname ices_request_jwt
#' @export
ices_patch_jwt <- function(url, body = list(), encode = "json",
                          username = NULL,
                          retry = TRUE, quiet = FALSE,
                          verbose = FALSE) {
  out <-
    ices_request_jwt(
      "PATCH", url,
      body = body, encode = encode, username = username,
      retry = retry, quiet = quiet, verbose = verbose
    )

  return(out)
}
