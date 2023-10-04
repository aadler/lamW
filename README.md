<!-- badges: start -->
[![CRAN Status Badge](https://www.r-pkg.org/badges/version/lamW)](https://CRAN.R-project.org/package=lamW)
[![](http://cranlogs.r-pkg.org/badges/last-month/lamW)](https://cran.r-project.org/package=lamW)
[![](https://cranlogs.r-pkg.org/badges/grand-total/lamW)](https://cran.r-project.org/package=lamW)
[![R-CMD-check](https://github.com/aadler/lamW/workflows/R-CMD-check/badge.svg)](https://github.com/aadler/lamW/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/aadler/lamW/branch/master/graph/badge.svg)](https://app.codecov.io/gh/aadler/lamW?branch=master)
[![OpenSSF Best Practices](https://bestpractices.coreinfrastructure.org/projects/2022/badge)](https://bestpractices.coreinfrastructure.org/projects/2022)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5874874.svg)](https://doi.org/10.5281/zenodo.5874874)
<!-- badges: end -->

# lamW
**lamW** is an `R` package which calculates the real-valued branches of the
[Lambert-W function](https://en.wikipedia.org/wiki/Lambert_W_function) without
the need to install the entire GSL. It uses compiled code and 
[`RcppParallel`](https://rcppcore.github.io/RcppParallel/) to achieve
significant speed.

## Citation
If you use the package, please cite it as:

  Avraham Adler (2015). lamW: Lambert-W Function. R package version 2.3.0.
  https://CRAN.R-project.org/package=lamW doi: 10.5281/zenodo.5874874

A BibTeX entry for LaTeX users is:

```
  @Manual{,
    title = {lamW: Lambert-W Function},
    author = {Avraham Adler},
    year = {2015},
    url = {https://CRAN.R-project.org/package=lamW},
    doi = "10.5281/zenodo.5874874",
    note = {R package version 2.3.0.},
  }
```
## Contributions
Please see
[CONTRIBUTING](https://github.com/aadler/Delaporte/blob/master/CONTRIBUTING.md).

## Roadmap
### Major

 * There are no plans for major changes in the foreseeable future
 
### Minor

 * There are no plans for minor changes in the foreseeable future

## Security
Please see [SECURITY](https://github.com/aadler/Delaporte/blob/master/).
