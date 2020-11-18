#' @rdname ices_request_jwt
#' @export
ices_get_jwt <- function(url,
                          username = getOption("ices.username"),
                          retry = TRUE, quiet = FALSE,
                          verbose = FALSE) {

  out <-
    ices_request_jwt(
      "GET", url,
      body = NULL, username = username,
      retry = retry, quiet = quiet, verbose = verbose
    )

  return(out)
}

#' @rdname ices_request_jwt
#' @export
ices_post_jwt <- function(url, body = list(),
                          username = getOption("ices.username"),
                          retry = TRUE, quiet = FALSE,
                          verbose = FALSE) {
  out <-
    ices_request_jwt(
      "POST", url,
      body = body, username = username,
      retry = retry, quiet = quiet, verbose = verbose
    )

  return(out)
}

#' @rdname ices_request_jwt
#' @export
ices_patch_jwt <- function(url, body = list(),
                          username = getOption("ices.username"),
                          retry = TRUE, quiet = FALSE,
                          verbose = FALSE) {
  out <-
    ices_request_jwt(
      "PATCH", url,
      body = body, username = username,
      retry = retry, quiet = quiet, verbose = verbose
    )

  return(out)
}
