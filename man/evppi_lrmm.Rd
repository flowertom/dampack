% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evppi_lrmm.R
\name{evppi_lrmm}
\alias{evppi_lrmm}
\title{Estimation of the Expected Value of Partial Perfect Information (EVPPI)
using a linear regression metamodel approach}
\usage{
evppi_lrmm(nmb = NULL, params = NULL, sel.params = 1, verbose = F)
}
\arguments{
\item{nmb}{Matrix of net monetary benefits (NMB). Each column corresponds to 
the NMB of a different strategy.}

\item{params}{Vector or matrix of parameters.}

\item{sel.params}{A vector including the column index of parameters for 
which EVPPI should be estimated.}

\item{verbose}{Logical variable indicating if estimation progress should be 
reported.}
}
\value{
evppi A numeric vector of size one with the EVPPI of the selected 
parameters
}
\description{
\code{evppi_lrmm} is used to estimate the Expected Value of Partial Perfect 
Information (EVPPI) using a linear regression metamodel approach from a 
probabilistic sensitivity analysis (PSA) dataset.
}
\details{
The expected value of partial pefect information (EVPPI) is the expected 
value of perfect information from a subset of parameters of interest, 
\eqn{\theta_I} of a cost-effectiveness analysis (CEA) of \eqn{D} different 
strategies with parameters \eqn{\theta = \{ \theta_I, \theta_C\}}, where 
\eqn{\theta_C} is the set of complimenatry parameters of the CEA. The 
function \code{evppi_lrmm} computes the EVPPI of \eqn{\theta_I} from a 
matrix of net monetary benefits \eqn{B} of the CEA. Each column of \eqn{B} 
corresponds to the net benefit \eqn{B_d} of strategy \eqn{d}. The function 
\code{evppi_lrmm} computes the EVPPI using a linear regression metamodel 
approach following these steps:
\enumerate{
\item Determine the optimal strategy \eqn{d^*} from the expected net 
benefits \eqn{\bar{B}}
\deqn{d^* = argmax_{d} \{\bar{B}\}}
\item Compute the opportunity loss for each \eqn{d} strategy, \eqn{L_d}
\deqn{L_d = B_d - B_{d^*}}
\item Estimate a linear metamodel for the opportunity loss of each \eqn{d} 
strategy, \eqn{L_d}, by regressing them on the spline basis functions of 
\eqn{\theta_I}, \eqn{f(\theta_I)}
\deqn{L_d = \beta_0 + f(\theta_I) + \epsilon,}
where \eqn{\epsilon} is the residual term that captures the complementary 
parameters \eqn{\theta_C} and the difference between the original simulation 
model and the metamodel.
\item Compute the EVPPI of \eqn{\theta_I} using the estimated losses for 
each \eqn{d} strategy, \eqn{\hat{L}_d} from the linear regression metamodel 
and applying the following equation:
\deqn{EVPPI_{\theta_I} = \frac{1}{K}\sum_{i=1}^{K}\max_d(\hat{L}_d)}
The spline model in step 3 is fitted using the `mgcv` package.
}
}
\examples{
## Load mgcv package and matrixStats
library(mgcv)
library(matrixStats)
## Load PSA dataset
data(syndX)
## Net monetary benefit (NMB) matrix
nmb <- syndX[, 5:7]
## Matrix of model parameter inputs values theta
theta <- syndX[, 1:4]
## Optimal strategy (d*) based on the highest expected NMB
d.star <- which.max(colMeans(nmb))
d.star
## Define the Loss matrix
loss <- nmb - nmb[, d.star]
## Estimate EVPPI for parameter 1 (MeanVisitsA)
evppi_lrmm(nmb = nmb, params = theta, sel.params = 1, verbose = TRUE)
}
\references{
\enumerate{
\item Jalal H, Alarid-Escudero F. A General Gaussian Approximation Approach 
for Value of Information Analysis. Med Decis Making (in press). 2017. 
\item Strong M, Oakley JE, Brennan A. Estimating Multiparameter Partial 
Expected Value of Perfect Information from a Probabilistic Sensitivity 
Analysis Sample: A Nonparametric Regression Approach. Med Decis Making. 
2014;34(3):311–26. 
}
}
\keyword{Expected}
\keyword{Information}
\keyword{Linear}
\keyword{Partial}
\keyword{Perfect}
\keyword{Splines}
\keyword{Value}
\keyword{metamodel}
\keyword{of}
\keyword{regression}
