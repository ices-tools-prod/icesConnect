#' ices_request_jwt
#'
#' Perform a get request to a url using a javascript web token for authentication
#'
#' @param type the type of request to make, GET, POST or PATCH
#' @param url the url to make the request to
#' @param body optional body of request
#' @param encode If the body is a named list, how should it be encoded?
#' @param username the ices username to perform the request as,
#'   Default: \code{getOption("ices.username")}
#' @param retry if initial request fails, should a retry be made, Default: TRUE
#' @param quiet suppress informative messages to the console
#' @param verbose should the http request return verbose output
#' @param jwt option to supply a token bypassing the ices_token() route, if "" no token is used
#' @param content logical, if TRUE the content of the response is returned, if FALSE the http response object is returned
#' @param use_token logical, if TRUE the token is used, if FALSE the token is not used
#'
#' @return http response object
#'
#' @examples
#' \dontrun{
#' # this function is interactive and asks the user for a password
#' ices_request_jwt("GET", "https://taf.ices.dk/vms/api/gearwidths")
#' ices_get_jwt("https://taf.ices.dk/vms/api/gearwidths")
#'
#' the top level function
#' ices_get("https://taf.ices.dk/vms/api/gearwidths", content = FALSE, use_token = TRUE)
#' ices_get("https://taf.ices.dk/vms/api/gearwidths", content = TRUE)
#' }
#' @seealso
#'  \code{\link[icesConnect]{ices_token}}
#'  \code{\link[httr]{GET}},\code{\link[httr]{add_headers}},\code{\link[httr]{stop_for_status}},\code{\link[httr]{status_code}}
#' @rdname ices_request_jwt
#'
#' @importFrom httr GET add_headers message_for_status status_code stop_for_status
#'
#' @export

ices_request_jwt <- function(type = c("GET", "POST", "PATCH"),
                        url,
                        body = NULL,
                        encode = c("multipart", "form", "json", "raw"),
                        username = NULL,
                        retry = TRUE,
                        quiet = FALSE,
                        verbose = FALSE,
                        jwt = NULL) {
  type <- match.arg(type)
  HTTPFUN <- getExportedValue("httr", type)

  #if (getOption("icesConnect.messages")) {
  if (!quiet) {
    message(paste0(type, "ing ... ", url))
  }

  if (is.null(jwt)) {
    jwt <- ices_token(username)
    if (!quiet && nzchar(jwt)) {
      message("using token for user ICES\\", token_user(jwt))
    }
  } else if (nzchar(jwt)) {
    # check token is valid
    token_contents <- try(decode_token(jwt), silent = TRUE)
    if (inherits(token_contents, "try-error")) {
      warning("supplied token is not valid, or username not set, please see ?set_username.")
      return(NULL)
    }
    if (!quiet) {
      message("using user supplied token for user ICES\\", token_user(jwt))
    }
  }

  # set up args
  args <-
    list(
      url,
      body = body,
      encode = encode
    )

  if (nzchar(jwt)) {
    args <- c(args, list(httr::add_headers(Authorization = paste("Bearer", jwt))))
  } else {
    if (!quiet) {
      message("no token used")
    }
  }

  if (verbose) {
    args <- c(args, list(httr::verbose(info = TRUE)))
  }

  # read url contents
  resp <- do.call(HTTPFUN, args)

  # check return code
  if (!quiet) {
    httr::message_for_status(resp)
    message("\n")
  }

  if (httr::status_code(resp) == 404 & retry) {
    # try again - sometimes the server seems to return 404 on the
    # first request
    message("Server not responding, doing one retry.")
    resp <- do.call(HTTPFUN, args)
  }

  msg_401 <-
    paste0(
      "You don't have access to this resource.\n",
      "Invalid or missing token. Please run:\n",
      "    icesConnect::ices_token()\n",
      "to create your personal access token.\n"
    )

  msg_403 <-
    paste0(
      "You don't have access to this resource. Please run:\n",
      "    icesConnect::ices_token()\n",
      "to create or update your personal access token.\n"
    )

  tryCatch(httr::stop_for_status(resp),
    http_404 = function(c) message(": Url doesn't exist - the server may not responding."),
    http_403 = function(c) message(msg_403),
    http_401 = function(c) message(msg_401),
    http_400 = function(c) message(": Check function arguments, probably a user error."),
    http_500 = function(c) message(": Something went wrong on the server :(")
  )

  # return
  return(resp)
}
