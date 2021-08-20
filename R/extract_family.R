#' @title Extract the family of a function for a loaded package
#'
#' @description Returns a character vector containing the family of a
#'   function for a loaded package.
#'
#' @param fnc_name String containing the name of the function.
#' @param package_name String containing the name of the loaded package.
#'
#' @examples
#' extract_family(
#'   fnc_name = "extract_family",
#'   package_name = "devtoolbox")
#'
#' @import utils
#'
#' @export

extract_family <- function(fnc_name, package_name){

  p <-
    fnc_name %>%
    utils::help(eval(package_name)) %>%
    get_help_file() %>% # duplicate of utils:::.getHelpFile()
    purrr::keep(~attr(.x, "Rd_tag") == "\\seealso") %>%
    purrr::map(as.character) %>%
    purrr::flatten_chr()


  if(length(p) == 0){

    return("")

  } else {
    p[[2]] %>% # Extract second element
      stringr::str_remove("Other ") %>%
      stringr::str_remove(":") %>%
      stringr::str_remove("[\n]") %>%
      stringr::str_trim()
  }
}