#' @title Compute recursive dependencies of packages
#'
#' @description
#' Compute recursive package dependencies of packages. Credits to 'pkgnet' for
#' the original function.
#'
#' @param package String specifying name of original package.
#' @param db Parameter to pass to 'tools::package_dependencies'
#' @param seen_packages String containing names of packages to exclude
#'
#' @export
recursive_dependencies <- function(package, db, seen_packages = NULL) {

  # If package is already seen (memoization)
  if (package %in% seen_packages){
    return(seen_packages)
  }

  # Otherwise, get all of packages dependencies, and call this function recursively
  deps <- unlist(tools::package_dependencies(
    package,
    reverse = FALSE,
    recursive = FALSE,
    db = db,
    which = c("Depends", "Imports")
  ))

  outPackages <- c(seen_packages, package)

  # Identify new packages to search dependencies for
  newDeps <- setdiff(deps, outPackages)
  for (dep in newDeps) {
    outPackages <- unique(c(
      outPackages,
      recursive_dependencies(
        package = dep,
        db = db,
        seen_packages = outPackages
      )
    ))
  }

  outPackages
}
