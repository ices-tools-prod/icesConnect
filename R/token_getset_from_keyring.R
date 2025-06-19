token_get_from_keyring <- function(...) {
  user_token <-
    read.dcf(
      file.path(config_dir(), "token.dcf"),
      fields = "token"
    )

  c(user_token)
}

token_set_from_keyring <- function(token, ...) {
  user_info <- list(
    token = token,
    token_type = "ices_token"
  )

  write.dcf(
    user_info,
    file.path(config_dir(), "token.dcf")
  )

  invisible(NULL)
}

#' @importFrom tools R_user_dir
config_dir <- function() {
  path <- R_user_dir("icesConnect", "config")

  # ensure exists
  if (!dir.exists(path)) {
    # create the directory if it doesn't exist
    dir.create(path, showWarnings = FALSE, recursive = TRUE)
  }

  path
}
