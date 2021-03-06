% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Exports.R
\name{isListCompressed}
\alias{isListCompressed}
\title{Check if elements are compressed in the file.}
\usage{
isListCompressed(file)
}
\arguments{
\item{file}{Name of file.}
}
\value{
\code{TRUE/FALSE}
}
\description{
Check if elements are compressed in the file.
}
\examples{
list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
saveList(object = list_1, file = "example.llo", compress = FALSE)
isListCompressed(file = "example.llo") # get FALSE

}
\seealso{
\code{\link{largeList}}
}
