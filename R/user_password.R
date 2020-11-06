
#' @importFrom getPass getPass

user_password <- function(msg) {
  res <- NULL
  while (is.null(res)) {
    res <- getPass::getPass(msg = msg)
  }
  res
}
