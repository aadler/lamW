\name{NEWS}
\alias{NEWS}
\title{NEWS file for the \code{\link[=lamW]{lamW} package}}

\section{Changes in version 0.0-2 (2015-05-20)}{
  \subsection{Bug Fixes}{
    \itemize{
      \item Remove extra parenthesis which was causing boolean to be passed to \code{fabs} (thanks to Dr. Brian Ripley)
    }
  }
  \subsection{Updates}{
    \itemize{
      \item Enhanced and cleaned documentation
      \item Added URL and Bugreports to DESCRIPTION
      \item Implemented minor optimizations to reduce number of needed calculations
      \item Added comments to source explaining Halley step and provenance of numeric coefficients in Pade approximant
      \item Cleaned up source code from unnecessary comments
      \item Added more robust unit testing
    }
  }
}

\section{Changes in version 0.0-1 (2015-05-19)}{
  \itemize{
    \item Initial release
  }
}