token_get_from_keyring <- function(...) {
  user_token <-
    read.dcf(
      file.path(config_dir(), "token.dcf"),
      fields = "token"
    )

  c(user_token)
}

# the R code given at https://data.ices.dk/token calls this function
# directly, with the username as a second argument, so keep the ...
token_set_from_keyring <- function(token, ...) {
  user_info <- list(
    token = token,
    token_type = "ices_token"
  )

  token_file <- file.path(config_dir(), "token.dcf")
  write.dcf(user_info, token_file)

  # the token should only be readable by the user
  Sys.chmod(token_file, mode = "0600")

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
