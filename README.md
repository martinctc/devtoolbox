# devtoolbox
Tools for the R developer

[![R build status](https://github.com/martinctc/devtoolbox/workflows/R-CMD-check/badge.svg)](https://github.com/martinctc/devtoolbox/actions/)
[![CodeFactor](https://www.codefactor.io/repository/github/martinctc/devtoolbox/badge)](https://www.codefactor.io/repository/github/martinctc/devtoolbox/)

## About

With {devtoolbox}, you can:

- Create a summary report for your R package listing the number of functions, download statistics, and documentation completeness
- Extract dependency statistics in a tidy data frame

Note that some features are only available if your package is a CRAN listed package, such as CRAN download statistics.

{devtoolbox} makes use of {cranlogs} and is heavily inspired {pkgnet}.

### Examples

See the following example reports:
- [sjlabelled](https://martinctc.github.io/devtoolbox/examples/sjlabelled_summary_report.html)
- [tidytext](https://martinctc.github.io/devtoolbox/examples/tidytext_summary_report.html)
- [wpa](https://martinctc.github.io/devtoolbox/examples/wpa_summary_report.html)

---

### Installation

{devtoolbox} is not released on CRAN (yet). 
You can install the latest development version from GitHub with:

```R
install.packages("devtools")
devtools::install_github("martinctc/devtoolbox")
```

---

### Contact

Please feel free to submit suggestions and report bugs: <https://github.com/martinctc/surveytoolbox/issues/>

Also check out my [website](https://martinctc.github.io) for my other work and packages.
