#' @title Run a summary of functions and the associated description for a loaded
#' package
#'
#' @description Return a data frame summarising functions, family, title,
#'   description, and arguments of a loaded package.
#'
#' @param package_name String providing the name of the loaded package, e.g. surveytoolbox
#'
#' @examples
#' library(devtoolbox)
#' generate_summary(package_name = "devtoolbox")
#'
#' @export
generate_summary <- function(package_name){

  pkg_string <- paste0("package:", package_name)

  fnc_names <- utils::lsf.str(pkg_string) %>% as.character()

  fnc_fam <-
    fnc_names %>%
    purrr::map_chr(extract_family, package_name = package_name)

  fnc_title <-
    fnc_names %>%
    purrr::map_chr(extract_title, package_name = package_name)

  fnc_desc <-
    fnc_names %>%
    purrr::map_chr(extract_desc, package_name = package_name)

  fnc_arg <-
    fnc_names %>%
    purrr::map_chr(extract_argument, package_name = package_name)

  dplyr::tibble(
    Functions = fnc_names,
    Family = fnc_fam,
    Title = fnc_title,
    Description = fnc_desc,
    Arguments = fnc_arg
    )
}
