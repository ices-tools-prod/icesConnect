
has_token <- function() {
  user_files <- list.files(config_dir())

  return(
    length(user_files) && "token.dcf" %in% user_files
  )
}
