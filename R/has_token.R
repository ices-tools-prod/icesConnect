
has_token <- function(username) {
  user_files <- list.files(config_dir())

  return(
    length(user_files) && paste0(username, ".dcf") %in% user_files
  )
}
