
#' @importFrom askpass askpass

user_password <- function(prompt) {
  res <- NULL
  while (is.null(res)) {
    res <- askpass::askpass(prompt = prompt)
  }
  res
}
