#' @title Extract the title of a function for a loaded package
#'
#' @description Returns a character vector containing the title of a
#'   function for a loaded package.
#'
#' @param fnc_name String containing the name of the function.
#' @param package_name String containing the name of the loaded package.
#'
#' @examples
#' extract_title(
#'   fnc_name = "extract_title",
#'   package_name = "devtoolbox")
#'
#' @return A character vector containing the title of a function for a loaded
#'   package.
#'
#' @import utils
#'
#' @export

extract_title <- function(fnc_name, package_name){
  fnc_name %>%
    utils::help(eval(package_name)) %>%
    get_help_file() %>% # duplicate of utils:::.getHelpFile()
    purrr::keep(~attr(.x, "Rd_tag") == "\\title") %>%
    purrr::map(as.character) %>%
    purrr::flatten_chr() %>%
    paste0(., collapse="") %>%
    stringr::str_remove("[\n]") %>%
    stringr::str_trim()
}
