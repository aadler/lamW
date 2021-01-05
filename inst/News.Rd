\name{NEWS}
\alias{NEWS}
\alias{Changelog}
\title{NEWS file for the lamW package}

\section{Version 2.0.0 (2021-01-05)}{
  \subsection{Changed}{
    \itemize{
      \item Used series expansion around 0 for more accurate return value for
      \eqn{x \le 10^{-16}} (thanks to Jerry Lewis)
      \item Contracted region around \eqn{\frac{-1}{e}}{-1/e} which returns -1
      to \code{Machine$double.eps}
      \item Converted continuous integration to Github actions
      \item Allow use of LTO
    }
  }
}

\section{Version 1.3.3 (2020-06-26)}{
  \subsection{Fixed}{
    \itemize{
      \item Corrected minor issues tripping CRAN checks
      \item Adjusted linking to other packages in help documentation
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Moved repository to Github
    }
  }
  \subsection{Added}{
    \itemize{
      \item Added travis, appveyor, and codecovr
      \item Added check for package version and behavior at
      \eqn{\frac{-1}{e}}{-1/e}
      \item explicit calls to \code{std::} in the C++ code
    }
  }
}

\section{Version 1.3.2 (2020-05-25)}{
  \subsection{Fixed}{
    \itemize{
      \item Corrected regression which treated PosInf and NegInf the same on
      principle branch (thanks to CRAN & Uwe Ligges)
    }
  }
  \subsection{Added}{
    \itemize{
      \item Added test to ensure PosInf and NegInf are properly identified
      accurately
      \item Expanded existing tests
    }
  }
}

\section{Version 1.3.1 (2020-05-24) [YANKED]}{
  \subsection{Added}{
    \itemize{
      \item Use R magic words and Rcpp sugar instead of calls to STD (caused
      regression)
      \item Added more tests near asymptotes and for real vs. integer
      \item Added ORCID to DESCRIPTION
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Reduced max interations in some loops as convergence acheived more
      quickly
      \item Refactored old nomenclature
      \item Cleaned code for whitespace and unnecessary comments
      \item Spellcheck and minor cleanup of help file
    }
  }
}

\section{Version 1.3.0 (2017-04-24)}{
  \subsection{Added}{
    \itemize{
      \item Added new package native routine registration.
    }
  }
}

\section{Version 1.2.0 (2016-10-26)}{
  \subsection{Changed}{
    \itemize{
      \item Now using RcppParallel for calculation. Speedup when calculating
      more than one value at a time should be noticeable, e.g. around a 5X
      speedup on an 8 core machine. There should be no noticeable change when
      calculating single values at a time.
    }
  }
}

\section{Version 1.1.1 (2016-05-02)}{
  \subsection{Added}{
    \itemize{
      \item Added testing for proper behavior near 0 due to log in Fritsch step
      implementation
    }
  }
  \subsection{Fixed}{
    \itemize{
      \item Edited NEWS.Rd so that it shows properly on CRAN
    }
  }
}

\section{Version 1.1.0 (2016-03-15)}{
  \subsection{Changed}{
    \itemize{
      \item Switched from exclusively using Halley iteration to usually using
      Fritsch iteration resulting in a significant increase in speed in both
      branches
    }
  }
}

\section{Version 1.0.0 (2015-12-27)}{
  \subsection{Added}{
    \itemize{
      \item Added explicit exportation of headers for use in the
      \link[lambertW]{LambertW} package (Thanks to Georg M. Goerg).
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Update to initial release
      \item Adjust NEWS to more closely follow
      \href{https://keepachangelog.com/}{keep a changelog} suggestions
      \item Removed mention of LambertW and its importing the \code{gsl} package
      from the documentation as it now imports this package instead.

    }
  }
}

\section{Version 0.1.2 (2015-10-07)}{
  \subsection{Added}{
    \itemize{
      \item Have both branches of the function return their respective limits.
      The main branch returns \code{Inf} when it is passed \code{Inf} and the
      secondary branch returns -\code{Inf} when it is passed 0 (Thanks to Georg
      M. Gorg)
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Make unit tests more robust
      \item Update code for tests for equality for changes in \code{testthat}
      package
    }
  }
}

\section{Version 0.1.1 (2015-05-20)}{
  \subsection{Fixed}{
    \itemize{
      \item Remove extra parenthesis which was causing boolean to be passed to
      \code{fabs} (thanks to Professor Brian Ripley)
    }
  }
  \subsection{Added}{
    \itemize{
      \item Added URL and Bugreports to DESCRIPTION
      \item Implemented minor optimizations to reduce number of needed
      calculations
      \item Added comments to source explaining Halley step and provenance of
      numeric coefficients in Pade approximant
      \item Added more robust unit testing
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Enhanced and cleaned documentation
      \item Cleaned up source code from unnecessary comments
    }
  }
}

\section{Version 0.0.1 (2015-05-19)}{
  \itemize{
    \item Initial release
  }
}
