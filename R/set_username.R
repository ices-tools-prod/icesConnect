#' Set your ICES username
#'
#' Back compatability function that does nothing. A username is no longer
#' needed: tokens are created at <https://data.ices.dk/token> and stored
#' using [set_token()].
#'
#' @param ... only here for back compatability, does nothing
#'
#' @return invisible NULL
#'
#' @rdname set_username
#'
#' @export
set_username <- function(...) {
  message("set_username() is no longer needed and does nothing, see ?set_token")
  invisible(NULL)
}
