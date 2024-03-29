#' @title Extract the description of a function for a loaded package
#'
#' @description Returns a character vector containing the description of a
#'   function for a loaded package.
#'
#' @param fnc_name String containing the name of the function.
#' @param package_name String containing the name of the loaded package.
#'
#' @examples
#' extract_desc(
#'   fnc_name = "extract_desc",
#'   package_name = "devtoolbox")
#'
#' @return A character vector containing the description of a function for a
#'   loaded package.
#'
#' @import utils
#'
#' @export

extract_desc <- function(fnc_name, package_name){

  help_text <-
    fnc_name %>%
    utils::help(eval(package_name))

  # Function not available
  if(length(help_text) == 0){

    return("")

  } else {

    help_text %>%
      get_help_file() %>% # duplicate of utils:::.getHelpFile()
      purrr::keep(~attr(.x, "Rd_tag") == "\\description") %>%
      purrr::map(as.character) %>%
      purrr::flatten_chr() %>%
      paste0(., collapse = "") %>%
      stringr::str_remove("[\n]") %>%
      stringr::str_trim()

  }

}
