#' Create a spatial contingency matrix from a list of contingencies
#'
#' Given a \code{list} of contingencies for each unit in a population of size \code{N},
#' \code{scmat} creates a matrix of local contingency matrix of size \code{NxN}
#' of 1's (if units i and j are contiguous) and 0's (otherwise).
#'
#' @param clist list of length N in which each element is a vector of id's continguous units
#' 
#' @export


spatialContMat <- function(clist){
    if(!is.list(clist)) stop('the argument should be a list of length N')
    N <- length(clist)

    out <- matrix(0,N,N)
    for(i in 1:N){
        out[i, clist[[i]] ] <- 1
    }
    return(out)
}
