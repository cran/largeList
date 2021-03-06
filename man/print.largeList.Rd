% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/operatorOverload.R
\name{print.largeList}
\alias{print.largeList}
\title{Overload of function print.}
\usage{
\method{print}{largeList}(x, ...)
}
\arguments{
\item{x}{A largeList object created by \code{\link{getList}}.}

\item{...}{arguments to be passed.}
}
\description{
If length of list dose not exceed getOption("max.print"), all elements will be printed,
otherwise, elements beyond getOption("max.print") will be omitted.
}
\examples{
largelist_object <- getList("example.llo", truncate = TRUE)
largelist_object[[]] <- list("A" = 1, "B" = 2, "C" = 3)  ## assign list to the list file
print(largelist_object) ## print to screen
largelist_object ## print to screen
}
\seealso{
\code{\link{largeList}}
}
