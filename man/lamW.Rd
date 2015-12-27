\name{lambertW}
\alias{lambertW0}
\alias{lambertWm1}
\title{
Lambert-W Function
}
\description{
The Lambert-W function is defined as the multivalued inverse of the function \eqn{z = f(W) = We^w}{z = f(W) = W*exp(W)}. The function has two branches. The principal branch is defined on the interval \eqn{[-\frac{1}{e}, \infty)}{[-1/e, Infinity)} and is always greater than -1. The second branch is defined on the interval \eqn{[-\frac{1}{e}, 0)}{[-1/e, 0)} and is always less than -1. The real-valed function is not defined for values less than \eqn{-\frac{1}{e}}{-1/e}.
}
\usage{
lambertW0(x)
lambertWm1(x)
}
\arguments{
  \item{x}{vector of values}}
\details{
The Lambert-W function is defined for all real \eqn{x \geq -\frac{1}{e}}{x >= -1/e}. It has two values in the interval \eqn{(-\frac{1}{e}, 0)}{(-1/e, 0)}. The values strictly greater than -1 are assigned to the \dQuote{principal} branch, also referred to as \eqn{W_0}{W0}, and the values strictly less than -1 are assigned to a secondary branch, referred to as \eqn{W_{-1}}{Wm1}. For non-negative \eqn{x}, only the principal branch exists as the other real-valued branch approaches negative infinity as \eqn{x} approaches 0. The algorithms used to calculate the values predominantly follow those in the reference, with some simplifications. There are many applications in which the Lambert-W function is useful, such as combinatorics, physics, and hydrology. The interested reader is directed to the reference for more detail.
}
\value{
Both functions return the appropriate values in the intervals for which they are defined. Outside of those intervals, they will return \code{NaN}, except that \code{lambertW0(Inf)} will return its limit \code{Inf} and \code{lambertWm1(0)} will return its limit -\code{Inf}.
}
\references{
Corless, R. M.; Gonnet, G. H.; Hare, D. E.; Jeffrey, D. J. & Knuth, D. E. "On the Lambert W function", Advances in Computational Mathematics, Springer, 1996, 5, 329-359
}
\author{
Avraham Adler \email{Avraham.Adler@gmail.com}
}
\seealso{
This package provides similar functionality to the \code{\link[gsl]{Lambert}} functions in the \code{gsl} package without having to obtain or install the \acronym{GSL}.
}
\examples{
lambertW0(exp(1))      ## Should equal 1, as 1 * exp(1) = e.
lambertW0(0)           ## Should equal 0, as 0 * exp(0) = 0.
lambertW0(-exp(-1))    ## Should equal -1.
lambertWm1(-exp(-1))   ## Should also equal -1.
A <- -2 * exp(-2)
lambertWm1(A)          ## Should equal -2
}
\keyword{NumericalMathematics}