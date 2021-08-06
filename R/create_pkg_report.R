#' @title Generate a package report in HTML
#'
#' @description
#' Create a report in HTML
#'
#' @param pkgname String containing the name of the package.
#' @param path Pass the file path and the desired file name, _excluding the file
#'   extension_. For example, `"my package report"`.
#'
#' @export
create_pkg_report <- function(pkgname,
                              path = paste(pkgname, "- summary report")){

  run_rmd(
    pkgname = pkgname,
    output_file = paste0(path, ".html"),
    report_title = paste0(pkgname, ": package report"),
    rmd_dir = system.file("rmd_template/package_summary/main.rmd", package = "devtoolbox"),
    output_format =
      flexdashboard::flex_dashboard(orientation = "columns",
                                    vertical_layout = "fill",
                                    source_code = "embed")
  )

}
