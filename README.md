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
[CONTRIBUTING.md](https://github.com/aadler/Delaporte/blob/master/CONTRIBUTING.md)

## Roadmap
### Major

 * There are no plans for major changes in the foreseeable future
 
### Minor

 * There are no plans for minor changes in the foreseeable future

## Security
### Expectations
This package is a calculation engine and requires no secrets or private
information. It is checked for memory leaks prior to releases to CRAN using
ASAN/UBSAN. Dissemination is handled by CRAN. Bugs are reported via the tracker
and handled as soon as possible.

### Assurance
The threat model is that a malicious actor would "poison" the package code by
adding in elements having nothing to do with the package's purpose but which
would be used for malicious purposes. This is protected against by having the
email account of the maintainer—used for verification by CRAN—protected by a
physical 2FA device (Yubikey) which is carried by the lead maintainer.
