\name{bezier}
\alias{bezier}
\title{Generates points along a Bezier curve or spline}
\description{
This function generates points along a Bezier curve or spline (concatenated Bezier curves) at specified parametric values. The Bezier curve can be of any degree and any number of dimensions.
}
\usage{
bezier(t, p, start = NULL, end = NULL, deg = NULL)
}
\arguments{
  \item{t}{a vector of parametric value(s), on the interval \code{[0, 1]} for a Bezier curve and on the interval \code{[0, n]} for a Bezier spline of \code{n} concatenated Bezier curves.}
  \item{p}{control points, input either as vector, matrix or list.}
  \item{start}{a vector giving an initial control point (must be of the same dimensionality as \code{p}). If provided, the first point of \code{p} is assumed to be the second control point.}
  \item{end}{a vector giving an final control point (must be of the same dimensionality as \code{p}). If provided, the last point of \code{p} is assumed to be the second to last control point.}
  \item{deg}{a numeric indicating the degree (or order) of a Bezier spline. For Bezier curves, the degree is computed based on the number of control points.}
}
\details{
This function uses the generalized formula for a Bezier curve (see \url{http://en.wikipedia.org/wiki/Bezier_curve#Explicit_definition}). If \code{deg} is \code{NULL}, \code{p} is assumed to be a Bezier curve and the degree (or order) is assumed to be the number of control points minus one. Thus, an input of two control points would return a linear Bezier curve, three control points would return a quadratic curve, four a cubic curve, etc.

For a Bezier curve, the parametric values, \code{t}, should be on the interval \code{[0, 1]}. Values greater than one are used to generate points along a Bezier spline, treating these as concatenated Bezier curves. For example, points would be generated along a Bezier spline consisting of a single Bezier curve using the interval \code{[0, 1]}, for a spline consisting of two concatenated Bezier curves, the interval would be \code{[0, 2]}, three curves would be \code{[0, 3]}, etc. An interval of \code{[1, 2]} for a Bezier spline consisting of two concatenated Bezier curves would return points along the second Bezier curve in the spline.

Note that evenly spaced parametric values for \code{t} does not produced evenly spaced points along a Bezier curve (except for a linear Bezier curve). Point density increases with sharper curvature along a Bezier. To generate evenly spaced points along a Bezier curve use the function \code{\link{pointsOnBezier}}.

For \code{p}, the first and last values are the fixed, start and end points (through which the Bezier curve must pass) and the values in-between dictate the curvature of the Bezier between the start and end points. For a unidimensional Bezier curve, \code{p} is simply a vector in which \code{length(p) - 1} specifies the degree. For multidimensional Bezier curves, \code{p} can either be a matrix or a list. If \code{p} is a matrix, each row is a control point where \code{nrow(p) - 1} specifies the degree of the curve and \code{ncol(p)} specifies the dimensions. Thus, if \code{p} is a matrix of five rows and three columns, \code{bezier} would generate points along a four-degree, three-dimensional Bezier curve. If \code{p} is a list, each list element (\code{p[[1]]}, \code{p[[2]]}, etc.) is a dimension of the Bezier curve and the values of each list element (\code{p[[1]][1]}, \code{p[[1]][2]}, etc.) are the control points. The same control points can be input via either matrix or list (see \code{MATRIX VS. LIST INPUT} in Examples).

Since a Bezier spline is a series of concatenated Bezier curves, the control points  alternate between end points (through which the Bezier must pass) and intermediate points (points to which the Bezier "reaches"). For a spline, the final end point of one Bezier curve is the starting end point for the next Bezier curve. Thus, for control point input the end point shared by two adjoining Bezier curves is listed just once. For example, a spline consisting of two Bezier curves with one intermediate point would require a total of five control points.

Since Bezier curves are parametric, the degree of each dimension need not be the same (i.e. each dimension can be specified by a different number of control points). This scenario is encountered when fitting Bezier curves to points in two or more dimensions if the Bezier curves are fit to each dimension separately (as with \code{\link{bezierCurveFit}}). Since the Bezier formula requires that the control points be of the same degree along each dimension, \code{bezier} elevates the degree of each dimension to the maximum degree using the function \code{\link{elevateBezierDegree}} (degree elevation does not change the shape of the Bezier curve). Inputs of this type (control points input as a list of non-uniform degrees along different dimensions) must be a single Bezier curve, not a Bezier spline.
}
\value{a vector (unidimensional Bezier) or matrix of bezier curve or spline points.}
\references{\url{http://en.wikipedia.org/wiki/Bezier_curve}}
\author{Aaron Olsen}
\seealso{
\code{\link{elevateBezierDegree}}, \code{\link{bezierArcLength}}, \code{\link{bezierCurveFit}}, \code{\link{pointsOnBezier}}
}
\examples{
## BEZIER CURVES ##
## SPECIFY PARAMETRIC VALUES FROM 0 TO 1 FOR SAMLPING A BEZIER CURVE
t <- seq(0, 1, length=100)

## BEZIER CONTROL POINTS
p <- matrix(c(0,0,0, 1,4,3, 2,2,0, 3,0,2, 5,5,0), nrow=5, ncol=3, byrow=TRUE)

## CREATE A 1D, 3-POINT BEZIER CURVE
bezier_points <- bezier(t=t, p=p[1:3, 1])

## CREATE THE SAME 1D, 3-POINT BEZIER CURVE, SPECIFYING THE START AND END POINTS SEPARATELY
bezier_points <- bezier(t=t, p=p[2, 1], start=p[1, 1], end=p[3, 1])

## CREATE A 2D, 3-POINT BEZIER CURVE
bezier_points <- bezier(t=t, p=p[1:3, 1:2])

## CREATE A 2D, 5-POINT BEZIER CURVE
bezier_points <- bezier(t=t, p=p[, 1:2])

## PLOT A BEZIER CURVE
## NOTE THAT POINTS ARE NOT EVENLY SPACED ALONG THE CURVE
plot(bezier(t=t, p=p[, 1:2]))

## CREATE A 3D, 3-POINT BEZIER CURVE
bezier_points <- bezier(t=t, p=p[1:3, ])

## CREATE A 3D, 5-POINT BEZIER CURVE
bezier_points <- bezier(t=t, p=p)


## MATRIX VS. LIST INPUT ##
## BEZIER CURVE WITH MATRIX INPUT
p <- matrix(c(0,0,0, 1,4,3, 2,2,0, 3,0,2, 5,5,0), nrow=5, ncol=3, byrow=TRUE)
bezier(t=seq(0, 1, length=10), p=p)

## THE SAME CONTROL POINTS INPUT AS LIST
p <- list(c(0, 1, 2, 3, 5), c(0, 4, 2, 0, 5), c(0, 3, 0, 2, 0))
bezier(t=seq(0, 1, length=10), p=p)


## BEZIER SPLINES ##
## SPECIFY PARAMETRIC VALUES FROM 0 TO 3 FOR SAMLPING A BEZIER SPLINE
t <- seq(0, 3, length=100)

## BEZIER CONTROL POINTS
p <- matrix(c(0,0,0, 1,4,3, 2,2,0, 3,0,2, 5,5,0, 8,0,4, 8,3,7), nrow=7, ncol=3, byrow=TRUE)

## CREATE A 2D BEZIER SPLINE WITH 3, 2-DEGREE BEZIER CURVES
bezier_points <- bezier(t=t, p=p[, 1:2], deg=2)

## PLOT BEZIER SPLINE
plot(bezier_points)

## PLOT FIXED POINTS ALONG SPLINE IN RED
points(rbind(p[1, ], p[3, ], p[5, ], p[7, ]), col="red", cex=0.75)

## CREATE A 3D BEZIER SPLINE WITH 3, 2-DEGREE BEZIER CURVES
bezier_points <- bezier(t=t, p=p, deg=2)


## BEZIER CURVE WITH DIFFERENT DEGREES FOR EACH DIMENSION ##
## LIST OF CONTROL POINTS FOR TWO DIMENSIONS
p_list <- list(c(0, 2, 1, 0), c(0, 4, 2, 0, 5, 0))

## CREATE 2D BEZIER CURVE WITH DIFFERENT NUMBERS OF CONTROL POINTS FOR EACH DIMENSION
bezier(t=seq(0, 1, length=100), p=p_list)
}
\keyword{ bezier }
\keyword{ curve }
