% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_desc.R
\name{extract_desc}
\alias{extract_desc}
\title{Extract the description of a function for a loaded package}
\usage{
extract_desc(fnc_name, package_name)
}
\arguments{
\item{fnc_name}{String containing the name of the function.}

\item{package_name}{String containing the name of the loaded package.}
}
\value{
A character vector containing the description of a function for a
loaded package.
}
\description{
Returns a character vector containing the description of a
function for a loaded package.
}
\examples{
extract_desc(
  fnc_name = "extract_desc",
  package_name = "devtoolbox")

}
