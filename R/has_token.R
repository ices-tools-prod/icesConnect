
#' @importFrom keyring key_list
has_token <- function(username) {
  keys <- keyring::key_list()

  if (nrow(keys)) {
    return(username %in% keys$username[keys$service == "ices_token"])
  }

  FALSE
}