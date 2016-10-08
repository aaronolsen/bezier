\name{elevateBezierDegree}
\alias{elevateBezierDegree}
\title{Raises the degree of a Bezier curve}
\description{
This function raises the degree (or order) of a Bezier curve to a specified degree. Degree elevation increases the number of control points describing the Bezier without changing its shape.
}
\usage{
elevateBezierDegree(p, deg)
}
\arguments{
  \item{p}{a vector of unidimensional Bezier control points.}
  \item{deg}{the degree to which the Bezier curve is to be elevated.}
}
\details{
Degree elevation of a Bezier curve increases the number of control points without changing the curve shape. This is useful when the number of control points differs for different dimensions of the curve, such as when Bezier curves are fit separately to each dimension of a multidimensional point set (as in \code{\link{bezierCurveFit}}). In order to perform degree elevation on a matrix of control points (multidimensional control points), \code{elevateBezierDegree} can be called on each dimension individually (using \code{apply} as in the example below).

The degree of a Bezier curve is one less than the number of control points (including the start and end point). If the input \code{deg} is equal to the current degree of the Bezier, the input control points are returned unmodified.
}
\value{a vector of new Bezier control points of the specified degree.}
\references{
\url{http://www.cs.mtu.edu/~shene/COURSES/cs3621/NOTES/spline/Bezier/bezier-elev.html}
}
\author{Aaron Olsen}
\seealso{\code{\link{bezier}}, \code{\link{bezierCurveFit}}}
\examples{

## 4 DEGREE BEZIER CONTROL POINTS
p4 <- matrix(c(0,0, 1,4, 2,2, 3,0, 5,5), nrow=5, ncol=2, byrow=TRUE)

## GENERATE BEZIER CURVE FOR 4TH DEGREE BEZIER
b4 <- bezier(t=seq(0, 1, length=100), p=p4)

## ELEVATE BEZIER DEGREE
p5 <- apply(p4, 2, elevateBezierDegree, deg=5)

## GENERATE BEZIER CURVE FOR 5TH DEGREE BEZIER
b5 <- bezier(t=seq(0, 1, length=100), p=p5)

## ELEVATE BEZIER DEGREE
p6 <- apply(p4, 2, elevateBezierDegree, deg=6)

## GENERATE BEZIER CURVE FOR 6TH DEGREE BEZIER
b6 <- bezier(t=seq(0, 1, length=100), p=p6)

## PLOT ORIGINAL 4TH DEGREE BEZIER POINTS
plot(b4)

## PLOT 5TH DEGREE BEZIER POINTS WITHIN 4TH DEGREE POINTS
points(b5, col="red", cex=0.75)

## PLOT 6TH DEGREE BEZIER POINTS WITHIN 4TH DEGREE POINTS
## NOTE THAT POINTS COINCIDE EXACTLY WITH LOWER DEGREES
## THE CURVE IS UNCHANGED BY DEGREE ELEVATION
points(b6, col="green", cex=0.5)
}