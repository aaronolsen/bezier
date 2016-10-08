\name{bezierCurveFit}
\alias{bezierCurveFit}
\title{Fits a Bezier curve to a set of points}
\description{
Fits a Bezier curve of any degree and dimension to a set of points. A range or particular number of control points can be specified. If a range of control points is input, \code{bezierCurveFit} will find the minimum number of control points required to reach a specified residual standard error threshold. \code{bezierCurveFit} is intended to fit a Bezier curve to a large number of sample points, at least double the number of expected Bezier control points, and therefore differs from Bezier curve interpolation, in which the number of sample points are approximately equal to the number of expected Bezier control points.
}
\usage{
bezierCurveFit(m, min.control.points = 3, max.control.points = 20, 
               fix.start.end = FALSE, max.rse = NULL, 
               max.rse.percent.change = 0.01, na.fill = FALSE)
}
\arguments{
  \item{m}{a vector or matrix of points to which the Bezier curve is to be fit.}
  \item{min.control.points}{the minimum number of control points to use in the curve fit.}
  \item{max.control.points}{the maximum number of control points to use in the curve fit.}
  \item{fix.start.end}{whether the curve fit should be constrained to start and end at the first and last points in \code{m}, respectively.}
  \item{max.rse}{the threshold for residual standard error at which curve fitting is stopped.}
  \item{max.rse.percent.change}{the threshold for percent change in residual standard error at which curve fitting is stopped.}
  \item{na.fill}{logical indicating whether missing points (value of \code{NA}) in \code{m} should be filled by linear interpolation between neighboring non-\code{NA} points. Start and end points cannot be NA.}
}
\details{
This function fits a Bezier curve to a vector or matrix of points. If \code{m} is a vector, the fitted curve is unidimensional. If \code{m} is a matrix, a multidimensional fitted curve is returned (where the number of dimensions is equal to \code{ncol(m)}). In either case, the curve fitting is performed on each dimension separately. This can produce different number of control points for each dimension; \code{\link{bezier}} resolves this through degree elevation (\code{\link{elevateBezierDegree}}).

\code{min.control.points} specifies the minimum number of control points used in the curve fitting while \code{max.control.points} specifies the maximum. The number of control points includes the start and end points. If \code{min.control.points} is not equal to \code{max.control.points}, \code{bezierCurveFit} will find the minimum number of control points needed to reach the specified residual standard error threshold. If \code{min.control.points} is equal to \code{max.control.points}, the number of control points is fixed and \code{bezierCurveFit} will perform a single fit using that number of control points. \code{bezierCurveFit} is intended to fit a Bezier curve to a large number of sample points, at least double the number of expected Bezier control points, and therefore differs from Bezier curve interpolation, in which the number of sample points are approximately equal to the number of expected Bezier control points.

The \code{nls} function is used to find the control point coordinates that minimize the residual standard error (RSE) between the fitted Bezier curve and the input points \code{m}. If the number of control points is not fixed, the RSE is found for increasing numbers of control points and used to test for convergence. If the input convergence criteria are met, \code{bezierCurveFit} will return the control points at the current iteration. Thus, the number of control points may be less than \code{max.control.points}. The two convergence criteria are \code{max.rse} and \code{max.rse.percent.change}. If the absolute RSE reaches \code{max.rse}, \code{bezierCurveFit} stops increasing the number of control points and returns the fit at the current iteration.

Once the number of control points exceeds three, regression is used to find the change in RSE as a function of the number of control points. A function is fit to RSE versus the number of control points (a linear function for 3-6 points and a three-parameter exponential function for 7 or more points) to find the rate of change in RSE (the slope). The slope at the current number of control points is divided by the current RSE to find the percent change in RSE. If the percent change in RSE reaches \code{max.rse.percent.change}, \code{bezierCurveFit} stops increasing the number of control points and returns the fit at the current iteration. If \code{max.rse} and \code{max.rse.percent.change} are both \code{NULL}, \code{bezierCurveFit} will continue fitting increasing numbers of control points until \code{max.control.points} is reached. 
}
\value{
a list of class \code{'bezierCurveFit'} with the following elements:
  \item{p}{a list of the control points for the fitted Bezier curve with one element per dimension. \code{p} can be input into \code{\link{bezier}} as the \code{p} parameter. See \code{\link{bezier}} for details on Bezier control point formats.}
  \item{rse}{a vector of the final residual standard error for each dimension.}
  \item{fit.stopped.by}{a vector of the reason curve fitting was stopped (see "Reasons iterations stop" under "Examples").}
}
\author{Aaron Olsen}

\seealso{\code{\link{bezier}}, \code{\link{pointsOnBezier}}, \code{\link{elevateBezierDegree}}}
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
## DEFAULT IS THAT CURVE FIT IS NOT CONSTRAINED TO START AND END POINTS
bfitu <- bezierCurveFit(mrnorm)

## PLOT ORIGINAL BEZIER
plot(m, type="l")

## PLOT POINTS USED IN FITTING
points(mrnorm, col="green", cex=0.25)

## PLOT FIT CURVE
lines(bezier(t=seq(0, 1, length=500), p=bfitu$p), col="red", cex=0.25)
}
\keyword{ bezier }
\keyword{ curve fitting }
