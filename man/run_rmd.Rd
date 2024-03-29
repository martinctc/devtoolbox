% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_rmd.R
\name{run_rmd}
\alias{run_rmd}
\title{Run RMarkdown Report based on an existing RMarkdown file}
\usage{
run_rmd(
  output_format = rmarkdown::html_document(toc = TRUE, toc_depth = 6, theme = "cosmo"),
  output_file = "report.html",
  output_dir = getwd(),
  report_title = "Report",
  rmd_dir = system.file("rmd_template/minimal.rmd", package = "devtoolbox"),
  ...
)
}
\arguments{
\item{output_format}{output format in \code{rmarkdown::render()}. Default is
\code{rmarkdown::html_document(toc = TRUE, toc_depth = 6, theme = "cosmo")}.}

\item{output_file}{output file name in \code{rmarkdown::render()}. Default is
\code{"report.html"}.}

\item{output_dir}{output directory for report in \code{rmarkdown::render()}.
Default is user's current directory.}

\item{report_title}{report title. Default is \code{"Report"}.}

\item{rmd_dir}{string specifying the path to the directory containing the
RMarkdown template files. This uses the internal \code{minimal} template by
default.}

\item{\dots}{other arguments to be passed to \code{params}.}
}
\value{
Opens and saves a static HTML report in the active directory, using the
RMarkdown template as specified in the argument \code{rmd_dir}.
}
\description{
This is a support function that accepts parameters and creates a HTML
document based on an RMarkdown template. This function is taken from the
\code{generate_report2()} function from the 'wpa' package.
}
\note{
The implementation of this function was inspired by the 'DataExplorer'
package by boxuancui, with credits due to the original author.
}
\section{Running the report}{

You can run the minimal report and pass arguments directly to \code{run_rmd}:

\if{html}{\out{<div class="sourceCode R">}}\preformatted{run_rmd(pkgname = "devtoolbox")
}\if{html}{\out{</div>}}
}

