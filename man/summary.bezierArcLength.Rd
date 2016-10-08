\name{summary.bezierArcLength}
\alias{summary.bezierArcLength}
\alias{print.summary.bezierArcLength}
\title{Summary of a Bezier arc length estimation}
\description{
Prints a summary of the output of \code{\link{bezierArcLength}} (a list of class \code{"bezierArcLength"}). This includes the change in arc length once arc length estimation is stopped, the number of iterations until convergence and the number of points along the Bezier used to estimate arc length. If the input is a Bezier spline then the results are printed separately for each curve in the spline. See \code{\link{bezierArcLength}} for details.
}
\usage{
\method{summary}{bezierArcLength}(object, ...)
}
\arguments{
  \item{object}{a list of class \code{"bezierArcLength"} (the output of \code{\link{bezierArcLength}}).}
  \item{...}{further arguments passed to or from other methods.}
}
\value{a \code{NULL} value.}
\author{Aaron Olsen}
\seealso{\code{\link{bezierArcLength}}, \code{\link{bezier}}}
\examples{
## BEZIER CURVE ARC LENGTH ESTIMATION ##
## BEZIER CURVE CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2), nrow=3, ncol=2, byrow=TRUE)

## FIND THE ARC LENGTH ALONG THE BEZIER CURVE
bcurve <- bezierArcLength(p=p, t1=0, t2=1)

## PRINT SUMMARY
print(summary(bcurve))


## BEZIER SPLINE ARC LENGTH ##
## BEZIER SPLINE CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2, 3,0, 4,4), nrow=5, ncol=2, byrow=TRUE)

## FIND THE ARC LENGTH ALONG THE BEZIER SPLINE
## HERE t2 = 1 SO ARC LENGTH IS ONLY CALCULATED FOR THE
##   FIRST BEZIER CURVE OF THE SPLINE
bspline <- bezierArcLength(p=p, t1=0, t2=2, deg=2)

## PRINT SUMMARY
print(summary(bspline))
}
\keyword{ bezier }
\keyword{ arc length }
