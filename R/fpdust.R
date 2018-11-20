#' Select a sample from a finite population using FPDUST procedure.
#'
#' Select a sample of size n from a finite population given a spatial
#' contingency matrix, the sample size \code{n}, and a parameter \code{beta}.
#'
#' @param spMat a matrix representing spatial contingency among population units,
#'         with dimension \code{NxN} and whose values are 1's (adjacent units) or 0's (otherwisex)
#' @param n integer scalar representing the sample size
#' @param beta a real number <1 representing a modifier of the probability of
#'             selection for units that are adjacent to already selected units
#'
#' @return a logical vector indicating which units have been selected
#'         (TRUE if selected, FALSE otherwise)
#'
#' @export


fpdust <- function(spMat,n,beta){

    ## Check input
    if(!is.matrix(spMat)) stop("Argument spMat should be anobject of class matrix!")
    if(ncol(spMat) != nrow(spMat)) stop("spMat should be a square matrix!")
    if( !is.atomic(n)) stop("Argument n must be a numeric scalar")
    if( !is.numeric(n) ) stop("Argument n must be numeric!")
    if( n<2) stop("The sample size n should be >=2")
    if( beta>1) stop("The parameter beta should be <1")


    if(beta >= 1) stop('The argument beta should be strictly less than 1')
    n <- floor(n)
    N <- nrow(spMat)

    if(N < n) stop('n is greater than population size')
    diag(spMat) <- 0 #to be sure units are not considered adjacent to themselves
    sv <- rep(FALSE,N) #vector of sampled units
    ct <- rep(FALSE,N) #vector of adjacent units

    sv[sample(1:N, 1)] <- TRUE
    ct <- as.logical(spMat[sv,])

    for(k in 2:n){
        p <- (1-sv) * (1 - beta*ct) / (N - k + 1 - sum(ct)*beta)
        # print(sum(p))
        i <- sample(1:N,1,prob=p)
        sv[i] <- TRUE
        ct <- ct | spMat[i,]
        ct <- ct * xor(ct,sv)
    }

    return(sv)

}
