# devtoolbox
Tools for the R developer

## About

With {devtoolbox}, you can:

- Create a summary report for your R package listing the number of functions, download statistics, and documentation completeness
- Extract dependency statistics in a tidy data frame

Note that some features are only available if your package is a CRAN listed package, such as CRAN download statistics.

{devtoolbox} makes use of {cranlogs} and is heavily inspired {pkgnet}.

---

### Installation

{devtoolbox} is not released on CRAN (yet). 
You can install the latest development version from GitHub with:

```R
install.packages("devtools")
devtools::install_github("martinctc/devtoolbox")
```
---
