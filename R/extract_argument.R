#' @title Extract the arguments of a function for a loaded package
#'
#' @description Returns a character vector containing the arguments of a
#'   function for a loaded package. Arguments are separated by semi-colons.
#'
#' @param fnc_name String containing the name of the function.
#' @param package_name String containing the name of the loaded package.
#'
#' @examples
#' extract_argument(
#'   fnc_name = "extract_argument",
#'   package_name = "devtoolbox")
#'
#' @return A character vector of length 1 containing the arguments of a function
#'   for a loaded package. Multiple arguments are separated by a semi-colon.
#'
#' @import utils
#'
#' @export

extract_argument <- function(fnc_name, package_name){

  fnc_name %>%
    utils::help(eval(package_name)) %>%
    get_help_file() %>% # duplicate of utils:::.getHelpFile()
    purrr::keep(~attr(.x, "Rd_tag") == "\\arguments") %>%
    purrr::map(as.character) %>%
    purrr::flatten_chr() -> p

  if(length(p) == 0){
    return("")
  } else {
    p %>%
      stringr::str_remove_all(., "[\n]") %>%
      .[. != ""] %>% # remove blanks
      stringr::str_trim() %>%
      stringr::str_remove_all("list\\(") %>% # clean up
      stringr::str_remove_all(",.+") %>% # remove argument description
      stringr::str_remove_all("[:punct:]") %>% # remove all non-words
      paste(collapse = "; ")
  }
}
