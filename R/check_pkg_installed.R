#' @title Check whether package is installed and return an error message
#'
#' @description Checks whether a package is installed in the user's machine
#' based on a search on the package name string. If the package is not
#' installed, an error message is returned.
#'
#' @param pkgname String containing the name of the package to check whether is
#' installed.
#'
#' @return If the installed package does not exist, an error message is returned
#'   informing the user that it is the case.
#'
#' @noRd
#'
check_pkg_installed <- function(pkgname) {

  mtry <- try(find.package(package = pkgname))

  wrap <- function(string, wrapper = '"'){
    paste0(wrapper, string, wrapper)
  }

  if (inherits(mtry, "try-error")) {
    stop(
      paste0(
        "\n\nPackage ", wrap(pkgname, wrapper = "`"),
        " is required to run this function and is currently not installed.\n",
        "Please install package ",
        wrap(pkgname, wrapper = "`"),
        " to proceed. "
      )
    )
  }
}
