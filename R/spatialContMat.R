#' Create a spatial contingency matrix from a list of contingencies
#'
#' Create a matrix of local contingency matrix of size \code{NxN} starting from
#' a list.
#'
#'
#' @param clist list of length N in which each element is a vector of id's continguous units
#'
#'
#' @details
#' The input argument \code{clist} should be a list of lenght N. Each element of
#' this list must be a numeric vector, including the indices of the units that
#' are contiguous to the unit corresponding to the list element.
#' Function \code{spatialContingency} returns a matrix whose values are 1's (contiguous units)
#' and 0's (non-contiguous units).
#'
#' @export
#'


spatialContMat <- function(clist){

    if(!is.list(clist)) stop('the argument should be a list of length N')
    N <- length(clist)

    out <- lapply(seq_len(N), function(i) {
        v <- rep(0, N)
        v[ clist[[i]] ] <- 1
        return(v)
    } )
    out <- Reduce(rbind, out)
    diag(out) <- 0

    return(out)
}
