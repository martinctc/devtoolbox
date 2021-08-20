#' @title Generate a package report in HTML
#'
#' @description
#' Create a report in HTML
#'
#' @param pkgname String containing the name of the package.
#' @param path Pass the file path and the desired file name, _excluding the file
#'   extension_. For example, `"my package report"`.
#' @param from String in the format of `YYYY-MM-DD` specifying the start date of
#'   the reporting period. If set to `NULL`, the first day of the month of the
#'   system date will be used.
#' @param to String in the format of `YYYY-MM-DD` specifying the end date of the
#'   reporting period. If set to `NULL`, the last day of the month of the system
#'   date will be used.
#' @param gh String in the format of `owner/repo` to specify the GitHub
#'   repository that holds the package. Defaults to `NULL` by default, where
#'   GitHub statistics will be omitted.
#'
#' @return Opens and saves a static HTML file in the active working directory
#'   with the file name specified in `path`.
#'
#' @export
create_pkg_report <- function(pkgname,
                              from = NULL,
                              to = NULL,
                              path = paste0(
                                pkgname,
                                " - summary report",
                                from,
                                "_",
                                to
                                ),
                              gh = NULL){

  # dependencies required in running report
  check_pkg_installed(pkgname = "visNetwork")
  check_pkg_installed(pkgname = "pkgnet")


  if(is.null(from)){
    from <- lubridate::floor_date(x = Sys.Date(), unit = "month")
  }

  if(is.null(to)){
    to <- lubridate::ceiling_date(x = Sys.Date(), unit = "month") - 1
  }

  run_rmd(
    pkgname = pkgname,
    output_file = paste0(path, ".html"),
    report_title = paste0(pkgname, ": package report"),
    rmd_dir = system.file("rmd_template/package_summary/main.rmd", package = "devtoolbox"),
    output_format =
      flexdashboard::flex_dashboard(orientation = "columns",
                                    vertical_layout = "fill",
                                    source_code = "embed"),
    # Additional arguments
    from = from,
    to = to,
    gh = gh
  )
}
