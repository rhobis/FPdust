#' Select a sample from a finite population using FPDUST procedure.
#'
#' \code{fpdust} selects a sample of size n from a finite population given a spatial
#' contingency matrix and a parameter \code{beta}.
#'
#' @param spMat spatial contingency matrix for population units, it should be a \code{NxN}
#'          matrix of 1's (adjacent units) or 0's (otherwisex)
#' @param n integer representing sample size
#' @param beta a real number <1 representing a modifier of the probability of
#'             selection for units that are adjacent to already selected units
#'
#' @return a vector indicating which units have been selected (1=selected, 0 otherwise)
#'
#' @export


fpdust <- function(spMat,n,beta){
    if(beta >= 1) stop('beta should assume a value strictly less than 1')
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

    return(sv*1)

}
