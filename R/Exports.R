#' Get number of elements in a list file.
#' @param file Name of file.
#' @return An integer.
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' saveList(object = list_1, file = "example.llo")
#' getListLength(file = "example.llo")
#' 
#' @export
getListLength <- function(file) {
    .Call(C_getListLength, file)
}

#' Check if elements are compressed in the file.
#' @param file Name of file.
#' @return \code{TRUE/FALSE}
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' saveList(object = list_1, file = "example.llo", compress = FALSE)
#' isListCompressed(file = "example.llo") # get FALSE
#' 
#' @export
isListCompressed <- function(file) {
  .Call(C_isListCompressed, file)
}

#' Get names of elements in a list file.
#' @param file Name of file.
#' @return A charater vector.
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' saveList(object = list_1, file = "example.llo")
#' getListName(file = "example.llo")
#' 
#' @export
getListName <- function(file) {
    .Call(C_getListName, file)
}

#' Get elements from a list file.
#' @details  
#' If no indices provided, the whole list will be read. Given index could be a numeric (integer) 
#' vector, a logical vector or a character vector representing the names. If there exist more then one elements 
#' corresponding to a given name, the first matched will be returned (not necessary to be the first
#' one in index order). If there are no elements with given name, \code{NULL} will be returned. \cr
#' Files created by \code{\link{saveRDS}} can't be read. \cr
#' When it takes long time to process, some verbose info will be printed to console, 
#' which can be switched off by setting \code{options(list(largeList.report.progress = FALSE))}.
#' @param file Name of file.
#' @param index \code{NULL} or a numeric, character, logical vector.
#' @return A list object.
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' saveList(object = list_1, file = "example.llo")
#' 
#' # read the whole list
#' readList(file = "example.llo")
#' 
#' # by numeric indices
#' readList(file = "example.llo", index = c(1, 3))
#' 
#' # by names
#' readList(file = "example.llo", index = c("A", "B"))
#' 
#' # by logical indices
#' readList(file = "example.llo", index = c(TRUE, FALSE, TRUE))
#' 
#' @export
readList <- function(file, index = NULL) {
    .Call(C_readList, file, index, getOption("largeList.report.progress"))
}

#' Remove elements from a list file.
#' @details 
#' It removes elements with given indices or names. This function may relocate all the data 
#' in the stored file, thus can be very slow! Please consider to call this function 
#' batchwise instead of one index by one index. \cr
#' When it takes long time to process, some verbose info will be printed to console, 
#' which can be switched off by setting \code{options(list(largeList.report.progress = FALSE))}.
#' @param file Name of file.
#' @param index  A numeric, logical or character vector.
#' @return invisible \code{TRUE} if no error occurs.
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' saveList(object = list_1, file = "example.llo")
#' 
#' # by numeric indices
#' removeFromList(file = "example.llo", index = c(2))
#' 
#' # by name
#' removeFromList(file = "example.llo", index = c("A"))
#' 
#' # by logical indices
#' removeFromList(file = "example.llo", index = c(TRUE))
#' 
#' @export
removeFromList <- function(file, index) {
    res <- .Call(C_removeFromList, file, index, getOption("largeList.report.progress"))
}

#' Save or append elements to a list file.
#' @details 
#' Save or append a list (with or without names) to a file.
#' Notice that, all names will be truncated to 16 characters. Rest attributes of lists
#' will be discarded. \cr
#' Files generated by this function are not readable by \code{\link{readRDS}}. \cr
#' When it takes long time to process, some verbose info will be printed to console, 
#' which can be switched off by setting \code{options(list(largeList.report.progress = FALSE))}.
#' @param object A list object to save or append.
#' @param file Name of file.
#' @param append \code{TRUE/FALSE}, \code{TRUE} refers to truncating and saving. 
#' \code{FALSE} refers to appending.
#' @param compress \code{TRUE/FALSE}, using compression or not.
#' @return invisible \code{TRUE} if no error occurs.
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' 
#' # save list_1 to file using compression.
#' saveList(object = list_1, file = "example.llo", append = FALSE, compress = TRUE)
#' 
#' # append list_1 to file, compress option will be extracted from the file.
#' saveList(object = list_1, file = "example.llo", append = TRUE)
#' 
#' @export

saveList <- function(object, file, append = FALSE, compress = TRUE) {
    res <- .Call(C_saveList, object, file, append, compress, getOption("largeList.report.progress"))
}

#' Modify elements in a list file.
#' @details 
#' It modifies elements with given indices by replacement values provided in parameter object. If length 
#' of replacement values is shorter than length of indices, values will be used circularly. This function may 
#' relocate all the data in the stored file, thus can be very slow! Please consider to call this
#' function batchwise instead of one by one. \cr
#' When it takes long time to process, some verbose info will be printed to console, 
#' which can be switched off by setting \code{options(list(largeList.report.progress = FALSE))}.
#' @param file Name of file.
#' @param index A numeric, logical or character vector.
#' @param object A list consisting of replacement values.
#' @return invisible \code{TRUE} if no error occurs.
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' saveList(object = list_1, file = "example.llo")
#' 
#' # by numeric indices
#' modifyInList(file = "example.llo", index = c(1,2), object = list("AA","BB"))
#' 
#' # by names
#' modifyInList(file = "example.llo", index = c("AA","BB"), object = list("A","B"))
#' 
#' # by logical indices
#' modifyInList(file = "example.llo", index = c(TRUE, FALSE, TRUE), object = list("A","B"))
#' 
#' @export
modifyInList <- function(file, index, object) {
  res <- .Call(C_modifyInList, file, index, object, getOption("largeList.report.progress"))
}

#' Modify names of elements in a list file.
#' @details 
#' Modify names of elements with given indices by replacement values provided in parameter name. If the length 
#' of replacement values is shorter than the length of indices, values will be used circularly. 
#' @param file Name of file.
#' @param index A numeric or logical vector.
#' @param name A character vector consisting replacement names.
#' @return invisible \code{TRUE} if no error occurs.
#' @seealso \code{\link{largeList}}
#' @examples 
#' list_1 <- list("A" = c(1,2), "B" = "abc", list(1, 2, 3))
#' saveList(object = list_1, file = "example.llo")
#' 
#' # by numeric indices
#' modifyNameInList(file = "example.llo", index = c(1,2), name = c("AA","BB"))
#' 
#' # by logical indices
#' modifyNameInList(file = "example.llo", index = c(TRUE, TRUE, FALSE), name = c("AA","BB"))
#' 
#' @export
modifyNameInList <- function(file, index, name) {
  res <- .Call(C_modifyNameInList, file, index, name)
}


