\name{compareBezierArcLength}
\alias{compareBezierArcLength}
\title{Returns difference between input length and a Bezier arc length}
\description{
This function calls \code{\link{bezierArcLength}} and returns the absolute difference between the Bezier curve or spline arc length and an input length. The primary use of this function is to supply \code{optim} with a single value for identifying a parametric value at a particular arc length in \code{\link{pointsOnBezier}}.
}
\usage{
compareBezierArcLength(p, l, t1 = 0, t2 = NULL, deg = NULL, 
                       relative.min.slope = 1e-6, absolute.min.slope = 0)
}
\arguments{
  \item{p}{control points, input either as vector, matrix or list (see \code{\link{bezier}}).}
  \item{l}{the length against which the arc length is compared.}
  \item{t1}{an initial parametric value for a Bezier curve or spline.}
  \item{t2}{a final parametric value for a Bezier curve or spline.}
  \item{deg}{a numeric indicating the degree (or order) of a Bezier spline. For Bezier curves, the degree is computed automatically based on the number of control points.}
  \item{relative.min.slope}{a numeric indicating at which change in arc length relative to the instaneous length estimated length is considered sufficiently close to the actual length.}
  \item{absolute.min.slope}{a numeric indicating at which absolute change in arc length estimated length is considered sufficiently close to the actual length.}
}
\details{
The performance of this function is identical to \code{\link{bezierArcLength}} except that fewer input parameters are available. See "Details" in \code{\link{bezierArcLength}}.
}
\value{
the absolute difference between the input length \code{l} and the Bezier arc length.
}
\author{Aaron Olsen}

\seealso{
\code{\link{bezier}}, \code{\link{pointsOnBezier}}, \code{\link{bezierArcLength}}
}
\examples{
## BEZIER CURVE ARC LENGTH COMPARISON ##
## BEZIER CURVE CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2), nrow=3, ncol=2, byrow=TRUE)

## COMPARE THE BEZIER ARC LENGTH TO ZERO
## SIMPLY RETURNS ARC LENGTH
compareBezierArcLength(p=p, l=0)

## COMPARE THE BEZIER ARC LENGTH TO ONE
compareBezierArcLength(p=p, l=1)

## SPECIFYING DIFFERENT T PARAMETERS
compareBezierArcLength(p=p, l=1, t1=0.3, t2=0.8)


## BEZIER SPLINE ARC LENGTH COMPARISON ##
## BEZIER SPLINE CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2, 3,0, 4,4), nrow=5, ncol=2, byrow=TRUE)

## COMPARE THE BEZIER ARC LENGTH TO ZERO
## SIMPLY RETURNS ARC LENGTH
compareBezierArcLength(p=p, l=0, deg=2)
}
\keyword{ bezier }
\keyword{ arc length }