\name{summary.bezierCurveFit}
\alias{summary.bezierCurveFit}
\alias{print.summary.bezierCurveFit}
\title{Summary of a Bezier curve fit}
\description{
Prints a summary of the output of \code{\link{bezierCurveFit}} (a list of class \code{"bezierCurveFit"}). For each dimension of the point set being fitted, this includes the number of parameters used in the fit, the residual standard error and the reason the fit iterations were stopped. See \code{\link{bezierCurveFit}} for details.
}
\usage{
\method{summary}{bezierCurveFit}(object, ...)
}
\arguments{
  \item{object}{a list of class \code{"bezierCurveFit"} (the output of \code{\link{bezierCurveFit}}).}
  \item{...}{further arguments passed to or from other methods.}
}
\value{a \code{NULL} value.}
\author{Aaron Olsen}
\seealso{\code{\link{bezierCurveFit}}, \code{\link{bezier}}}
\examples{
## RUN BEZIER CURVE FIT ON BEZIER CURVE ##
## BEZIER CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2, 3,0, 5,5), nrow=5, ncol=2, byrow=TRUE)

## POINTS ON BEZIER
m <- bezier(t=seq(0, 1, length=300), p=p)

## RANDOM VARIATION (NOISE) AROUND POINTS
## SENDING EXACT POINTS WILL ISSUE WARNING IN NLM FUNCTION
mrnorm <- m + cbind(rnorm(nrow(m), 1, 0.1), rnorm(nrow(m), 1, 0.1))

## RESTORE POSITION OF POINTS
mrnorm <- mrnorm - cbind(rep(1, nrow(m)), rep(1, nrow(m)))

## RUN BEZIER CURVE FIT UNCONSTRAINED NUMBER OF CONTROL POINTS
bfit <- bezierCurveFit(mrnorm)

## GET CURVE FIT SUMMARY
print(summary(bfit))
}
\keyword{ bezier }
\keyword{ curve fitting }
