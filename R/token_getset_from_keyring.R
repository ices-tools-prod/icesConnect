token_get_from_keyring <- function(username) {
  usernames <- grep(paste0(username, "_[0-9]+"), keyring::key_list()$username, value = TRUE)
  token <- paste(sapply(sort(usernames), keyring::key_get, service = "ices_token"), collapse = "")

  token
}

token_set_from_keyring <- function(token, username) {
  if (nchar(token) > 2500) {
    token <-
      substring(
        token,
        seq(1, nchar(token), by = 2500),
        seq(1, nchar(token), by = 2500) - 1 + 2500
      )
  }

  for (i in seq_along(token)) {
    # set token in keyring
    keyring::key_set_with_value(
      service = "ices_token",
      username = paste0(username, "_", i),
      password = token[i]
    )
  }

  invisible(NULL)
}
