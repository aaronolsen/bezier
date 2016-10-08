\name{bezierArcLength}
\alias{bezierArcLength}
\title{Approximates the arc length of a Bezier curve or spline}
\description{
Approximates the arc length (the length along the curve) of a Bezier curve or spline over a specified parametric range. The Bezier curve can be of any degree and any number of dimensions. Either relative and/or absolute changes in arc length are used as criteria for convergence.
}
\usage{
bezierArcLength(p, t1 = 0, t2 = NULL, deg = NULL, relative.min.slope = 1e-06, 
                absolute.min.slope = 0, max.iter = 20, n = NULL)
}
\arguments{
  \item{p}{control points, input either as vector, matrix or list (see \code{\link{bezier}}).}
  \item{t1}{an initial parametric value for a Bezier curve or spline.}
  \item{t2}{a final parametric value for a Bezier curve or spline.}
  \item{deg}{a numeric indicating the degree (or order) of a Bezier spline. For Bezier curves, the degree is computed automatically based on the number of control points.}
  \item{relative.min.slope}{a numeric indicating at which change in arc length relative to the instaneous length estimated length is considered sufficiently close to the actual length.}
  \item{absolute.min.slope}{a numeric indicating at which absolute change in arc length estimated length is considered sufficiently close to the actual length.}
  \item{max.iter}{the maximum number of iterations to reach the convergence criteria.}
  \item{n}{a fixed number of points with which to calculate arc length.}
}
\details{
There is not an exact solution for the arc length of a Bezier curve of any degree and dimension so a numerical estimation approach is needed. \code{bezierArcLength} estimates arc length by generating a number of points along a Bezier curve (using \code{\link{bezier}}) and summing the interpoint distances. Given a sufficient number of points on the Bezier, the sum of interpoint distances should approximate the actual length of the Bezier. In the case of Bezier splines, the arc length of each constituent Bezier curve is estimated separately and then summed. In this case, the return values are vectors in which each element corresponds to a separate call to \code{bezierArcLength} for each Bezier curve.

The function first generates five points along the curve and sums the interpoint distance. This is repeated ten times, increasing the number of points along the curve by one (to 15). In this way, the arc length is estimated for a Bezier curve along a ten point range. A linear regression (\code{\link{lm}}) is fit to these arc lengths in order find the slope of how arc length changes as a function of the number of points along the Bezier. This slope is tested against the convergence criteria and, if the arc length has not converged, the slope is also used to guess  the next range of values over which arc length will be estimated. This is repeated, measuring the change in arc length over a ten point interval, until the change in arc length reaches the convergence criteria or the function exceeds the maximum number of iterations.

\code{t1} and \code{t2} control the range of parameter values over which \code{bezierArcLength} will estimate arc length. In this way, arc length can be estimated for a portion of the entire Bezier curve or spline. The \code{deg} specifies the degree (or order) of the Bezier curve or spline (see \code{\link{bezier}}).

The \code{relative.min.slope} and \code{absolute.min.slope} are two criteria used to evaluate whether the function has converged on the actual arc length. At each iteration, the change in arc length as a function of points along the curve is calculated both absolutely (in the same units as the control points) and relative to the maximum estimated arc length at that iteration. If the absolute change in arc length is less than \code{absolute.min.slope} or the relative change in arc length less than \code{relative.min.slope}, estimation is stopped and the current arc length returned. Either of the convergence criteria can be ignored by setting them to 0. The default for \code{absolute.min.slope} is set to zero since the desired value will depend on the units of the control points input by the user. If both \code{absolute.min.slope} and \code{relative.min.slope} are equal to 0 then the function will proceed until reaching the maximum number of iterations (\code{max.iter}).

A non-\code{NULL} input for \code{n} will simply return the sum of interpoint distances between \code{n} points along a Bezier curve or spline. No estimation is performed and the convergence criteria are ignored.
}
\value{
a list of class \code{"bezierArcLength"} with the following elements:
  \item{arc.length}{the estimated arc length along a Bezier curve or spline.}
  \item{slope.break}{the change in arc length when the estimation is stopped.}
  \item{n}{the number of points along the Bezier used to estimate arc length.}
  \item{break.cause}{the reason arc length estimation stopped.}
  \item{n.iter}{the number of iterations used in estimation.}

When the input arguments correspond to a Bezier spline, \code{slope.break}, \code{n}, \code{break.cause} and \code{n.iter} are vectors in which each element cooresponds to the output of \code{bezierArcLength} called for each constituent Bezier curve (see Details).
}
\author{Aaron Olsen}
\seealso{
\code{\link{bezier}}, \code{\link{pointsOnBezier}}
}
\examples{
## BEZIER CURVE ARC LENGTH ##
## BEZIER CURVE CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2), nrow=3, ncol=2, byrow=TRUE)

## FIND THE ARC LENGTH ALONG THE BEZIER CURVE
bezierArcLength(p=p, t1=0, t2=1)

## FIND THE ARC LENGTH ALONG THE BEZIER CURVE
## HERE WE FIND THE ARC LENGTH OVER A SUBSET OF A BEZIER CURVE
bezierArcLength(p=p, t1=0.3, t2=0.8)


## BEZIER SPLINE ARC LENGTH ##
## BEZIER SPLINE CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2, 3,0, 4,4), nrow=5, ncol=2, byrow=TRUE)

## FIND THE ARC LENGTH ALONG THE BEZIER SPLINE
## HERE t2 = 1 SO ARC LENGTH IS ONLY CALCULATED FOR THE
##   FIRST BEZIER CURVE OF THE SPLINE
bezierArcLength(p=p, t1=0, t2=1, deg=2)

## HERE t2 = 2 SO ARC LENGTH IS CALCULATED FOR BOTH THE
##   THE FIRST AND SECOND BEZIER CURVES
## SINCE THE TWO CURVES IN THE SPLINE ARE THE SAME -
##   JUST IN DIFFERENT ORIENTATIONS, THE ARC LENGTH
##   IS EXACTLY DOUBLE THE PREVIOUS ARC LENGTH
bezierArcLength(p=p, t1=0, t2=2, deg=2)


## COMPARE CONVERGENCE ##
## BEZIER SPLINE CONTROL POINTS
p <- matrix(c(0,0, 1,4, 2,2), nrow=3, ncol=2, byrow=TRUE)

## FIND ARC LENGTH BY ESTIMATION
bconv <- bezierArcLength(p=p, t1=0, t2=1)

## FIND ARC LENGTH WITH DIFFERENT NUMBERS OF POINTS
b1000 <- bezierArcLength(p=p, t1=0, t2=1, n=1000)
b10000 <- bezierArcLength(p=p, t1=0, t2=1, n=10000)
b100000 <- bezierArcLength(p=p, t1=0, t2=1, n=100000)

## COMPARE RESULTS
## ESTIMATION DIFFERS FROM 1000 PT SUM BY 0.0001311936
b1000$arc.length - bconv$arc.length

## ESTIMATION DIFFERS FROM 10000 PT SUM BY 0.0001321184
b10000$arc.length - bconv$arc.length

## ESTIMATION DIFFERS FROM 100000 PT SUM BY 0.0001321277
b100000$arc.length - bconv$arc.length
}
\keyword{ bezier }
\keyword{ arc length }
