token_get_from_keyring <- function(username) {
  user_token <-
    read.dcf(
      file.path(config_dir(), paste0(username, ".dcf")),
      fields = "token"
    )

  c(user_token)
}

token_set_from_keyring <- function(token, username) {
  user_info <- list(
    username = username,
    token = token,
    token_type = "ices_token"
  )

  write.dcf(
    user_info,
    file.path(config_dir(), paste0(username, ".dcf"))
  )

  invisible(NULL)
}

#' @importFrom tools R_user_dir
config_dir <- function() {
  path <- R_user_dir("icesConnect", "config")
  # ensure exists
  sapply(path, dir.create, showWarnings = FALSE, recursive = TRUE)

  path
}
