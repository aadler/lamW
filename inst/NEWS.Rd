% Copyright (c) 2015, Avraham Adler All rights reserved
% SPDX-License-Identifier: BSD-2-Clause

\name{NEWS}
\alias{NEWS}
\title{NEWS file for the lamW package}
\encoding{UTF-8}

\section{Version 2.2.4 (2024-06-16)}{
  \subsection{Added}{
    \itemize{
      \item Installed new version of \pkg{rhub} testing.
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Updated \acronym{DOI} to native \acronym{CRAN}.
      \item Minor changes to C code for consistency.
      \item Updated package metadata unit tests.
    }
  }
}

\section{Version 2.2.3 (2023-11-28)}{
  \subsection{Fixed}{
    \itemize{
      \item Package built with development version of \pkg{Rcpp} to remove
      \acronym{CRAN}'s \dQuote{string literal} errors.
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Corrected some headers in \file{NEWS.Rd}
    }
  }
}

\section{Version 2.2.2 (2023-11-20)}{
  \subsection{Fixed}{
    \itemize{
      \item \acronym{NEWS} was not rendering on \acronym{CRAN} because the file
      name used lowercase, \file{News.Rd}, and not \file{NEWS.Rd}.
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Tweaked documentation.
    }
  }
}

\section{Version 2.2.1 (2023-10-04)}{
  \subsection{Changed}{
    \itemize{
      \item Removed line from \file{NEWS.Rd} which may have been preventing
      proper rendering on \acronym{CRAN}.
      \item added \code{$(LTO_OPT)} to \file{Makevars} and \file{Makevars.win}
      and \code{UseLTO} to \file{DESCRIPTION}.
      \item Cleaned up \file{README.md} and moved citation, contributions, and
      security information to their own files.
    }
  }
}

\section{Version 2.2.0 (2023-08-07)}{
  \subsection{Fixed}{
    \itemize{
      \item Corrected initial guess for Fritsch step for \eqn{6.4\times 10^{-3}
      \lt x \le e}{6.4e-3 \lt x \le e}. Does not change results but may converge
      in one fewer step.
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Replaced Fritsch's \enc{Padé}{Pade} approximation with a degree-six
      polynomial minimax approximation for \eqn{x \in \left[-6.4\times 10^{-3},
      6.4\times 10^{-3} \right]}{x in [-6.4e-3, 6.4e-3]} with true values based
      on the non-underflowing Halley step. Should be faster than Halley
      iteration and more accurate than the Fritsch's \enc{Padé}{Pade}
      approximation.
      \item Various grammar, linting, and unit test updates.
    }
  }
  \subsection{Added}{
    \itemize{
      \item Added \code{methods} to \code{Suggests} as per
      \href{https://github.com/aadler/lamW/pull/1}{PR1} (Thanks
      \href{https://github.com/MichaelChirico}{Michael Chirico}).
    }
  }
}

\section{Version 2.1.2 (2023-02-28)}{
  \subsection{Changed}{
    \itemize{
      \item Adjusted \acronym{TBB} grain size to prevent parallelism for fewer
      than 4 elements.
      \item Streamlined C++ code to follow more logical if-else cascade.
      \item Removed unneeded setup from C++ and \R calls.
      \item Cleaned up documentation.
      \item CITATION updated to use \code{bibentry} per \acronym{CRAN} request.
      \item Updated internal code to be more compliant with personal style
      guide.
      \item Updated Github actions.
    }
  }
}

\section{Version 2.1.1 (2022-01-18)}{
  \subsection{Changed}{
    \itemize{
      \item Converted test suite to \pkg{tinytest} framework to reduce
      dependencies.
      \item Added \acronym{DOI} and \acronym{CFF} for citation purposes.
    }
  }
}

\section{Version 2.1.0 (2021-05-20)}{
  \subsection{Changed}{
    \itemize{
      \item Obtained access to original Fritsch paper and used supplied
      \enc{Padé}{Pade} expansion (equation 5) for values close to 0, eliminating
      the need for the Halley step close to 0 and speeding up code slightly.
    }
  }
}

\section{Version 2.0.0 (2021-01-05)}{
  \subsection{Changed}{
    \itemize{
      \item Used series expansion around 0 for more accurate return value for
      \eqn{x \le 10^{-16}}{x \le 1e-16} (thanks to Jerry Lewis).
      \item Contracted region around \eqn{-\frac{1}{e}}{-1/e} which returns -1
      to \code{Machine$double.eps}.
      \item Converted continuous integration to Github actions.
    }
  }
}

\section{Version 1.3.3 (2020-06-26)}{
  \subsection{Fixed}{
    \itemize{
      \item Corrected minor issues tripping \acronym{CRAN} checks.
      \item Adjusted linking to other packages in help documentation.
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Moved repository to Github.
    }
  }
  \subsection{Added}{
    \itemize{
      \item Added Travis, Appveyor, and Codecovr.
      \item Added check for package version and behavior at
      \eqn{-\frac{1}{e}}{-1/e}.
      \item explicit calls to \code{std::} in the C++ code.
    }
  }
}

\section{Version 1.3.2 (2020-05-25)}{
  \subsection{Fixed}{
    \itemize{
      \item Corrected regression which treated \eqn{\infty} and \eqn{-\infty} as
      the same on the principle branch (thanks to \acronym{CRAN} & Uwe Ligges).
    }
  }
  \subsection{Added}{
    \itemize{
      \item Added test to ensure \eqn{\infty} and \eqn{-\infty} are identified
      accurately.
      \item Expanded existing tests.
    }
  }
}

\section{Version 1.3.1 (2020-05-24) [YANKED]}{
  \subsection{Added}{
    \itemize{
      \item Use \R magic words and \pkg{Rcpp} sugar instead of calls to
      \acronym{STD} (caused regression).
      \item Added more tests near asymptotes and for real vs. integer.
      \item Added \acronym{ORCID} to DESCRIPTION.
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Reduced max interations in some loops as convergence acheived more
      quickly.
      \item Refactored old nomenclature.
      \item Cleaned code for whitespace and unnecessary comments.
      \item Spellcheck and minor cleanup of help file.
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
      \item Now using \pkg{RcppParallel} for calculation. Speedup when
      calculating more than one value at a time should be noticeable, e.g.
      around a 5X speedup on an 8 core machine. There should be no noticeable
      change when calculating single values at a time.
    }
  }
}

\section{Version 1.1.1 (2016-05-02)}{
  \subsection{Added}{
    \itemize{
      \item Added testing for proper behavior near 0 due to log in Fritsch step
      implementation.
    }
  }
  \subsection{Fixed}{
    \itemize{
      \item Edited NEWS.Rd so that it shows properly on \acronym{CRAN}.
    }
  }
}

\section{Version 1.1.0 (2016-03-15)}{
  \subsection{Changed}{
    \itemize{
      \item Switched from exclusively using Halley iteration to usually using
      Fritsch iteration resulting in a significant increase in speed in both
      branches.
    }
  }
}

\section{Version 1.0.0 (2015-12-27)}{
  \subsection{Added}{
    \itemize{
      \item Added explicit exportation of headers for use in the \pkg{LambertW}
      package (thanks to Georg M. Goerg).
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Update to initial release.
      \item Adjust NEWS to more closely follow
      \href{https://keepachangelog.com/}{keep a changelog} suggestions.
      \item Removed mention of \pkg{LambertW} and its importing the \pkg{gsl}
      package from the documentation as it now imports this package instead.

    }
  }
}

\section{Version 0.1.2 (2015-10-07)}{
  \subsection{Added}{
    \itemize{
      \item Have both branches of the function return their respective limits.
      The main branch returns \code{Inf} when it is passed \code{Inf} and the
      secondary branch returns -\code{Inf} when it is passed 0 (thanks to Georg
      M. Gorg).
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Make unit tests more robust.
      \item Update code for tests for equality for changes in \pkg{testthat}
      package.
    }
  }
}

\section{Version 0.1.1 (2015-05-20)}{
  \subsection{Fixed}{
    \itemize{
      \item Remove extra parenthesis which was causing boolean to be passed to
      \code{fabs} (thanks to Professor Brian Ripley).
    }
  }
  \subsection{Added}{
    \itemize{
      \item Added \acronym{URL} and Bugreports to DESCRIPTION.
      \item Implemented minor optimizations to reduce number of needed
      calculations.
      \item Added comments to source explaining Halley step and provenance of
      numeric coefficients in \enc{Padé}{Pade} approximant.
      \item Added more robust unit testing.
    }
  }
  \subsection{Changed}{
    \itemize{
      \item Enhanced and cleaned documentation.
      \item Cleaned up source code from unnecessary comments.
    }
  }
}

\section{Version 0.0.1 (2015-05-19)}{
  \subsection{Added}{
    \itemize{
      \item Initial release.
    }
  }
}
