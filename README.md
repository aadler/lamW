<!-- badges: start -->
[(https://www.r-pkg.org/badges/version/lamW)](https://CRAN.R-project.org/package=lamW)
[(https://bestpractices.coreinfrastructure.org/projects/2022/badge)](https://bestpractices.coreinfrastructure.org/projects/2022)
[![Travis build status](https://travis-ci.com/aadler/lamW.svg?branch=master)](https://travis-ci.com/aadler/lamW)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/aadler/lamW?branch=master&svg=true)](https://ci.appveyor.com/project/aadler/lamW)
[![Codecov test coverage](https://codecov.io/gh/aadler/lamW/branch/master/graph/badge.svg)](https://codecov.io/gh/aadler/lamW?branch=master)
<!-- badges: end -->

# lamW

**lamW** is an `R` package which calculates the real-valued branches of the
[Lambert-W function](https://en.wikipedia.org/wiki/Lambert_W_function) without
the need to install the entire GSL. It uses compiled code and 
[`RcppParallel`](https://rcppcore.github.io/RcppParallel/) to achieve
significant speed.

## Citation
If you use the package, please cite it as:

  Avraham Adler (2015). lamW: Lambert-W Function. R package version 1.3.3.
  https://bitbucket.org/aadler/lamw

A BibTeX entry for LaTeX users is:

```
  @Manual{,
    title = {lamW: Lambert-W Function},
    author = {Avraham Adler},
    year = {2015},
    url = {https://CRAN.R-project.org/package=lamW},
    note = {R package version 1.3.3.},
  }
```

## Contributions
Please ensure that all contributions comply with both
[R and CRAN standards for packages](https://cran.r-project.org/doc/manuals/r-release/R-exts.html).

### Versioning
This project attempts to follow [Semantic Versioning](http://semver.org/)

### Changelog
This project attempts to follow the changelog system at
[Keep a CHANGELOG](http://keepachangelog.com/)

### Dependancies
This project intends to have as few dependancies as possible. Please consider
that when writing code.

### Style
Please review and conform to the current code stylistic choices (e.g. 80
character lines, two-space indentations).

### Documentation
Please provide valid .Rd files and **not** roxygen-style documentation.

### Tests
Please review the current test suite and supply similar `testthat`-compatible
unit tests for all added functionality.

### Submission
If you would like to contribute to the project, it may be prudent to first
contact the maintainer via email. A request or suggestion may be raised as an
issue as well. To supply a pull request (PR), please:

 1. Fork the project and then clone into your own local repository
 2. Create a branch in your repository in which you will make your changes
 3. Push that branch to your remote and then create a pull request
 
At this point, the PR will be discussed and eventually accepted or rejected.
