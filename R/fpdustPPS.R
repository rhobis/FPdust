#' Select a sample from a finite population using  a modified FPDUST procedure.
#'
#' \code{fpdustPPS} selects a sample of size n from a finite population given a spatial
#' contingency matrix, a parameter \code{beta}, and a size variable vector.
#'
#' @param spMat spatial contingency matrix for population units, it should be a \code{NxN}
#'          matrix of 1's (adjacent units) or 0's (otherwise)
#' @param X size measure vector
#' @param n integer representing sample size
#' @param beta a real number <1 representing a modifier of the probability of
#'             selection for units that are adjacent to already selected units
#'
#' @return a vector indicating which units have been selected (1=selected, 0 otherwise)
#'
#' @export


fpdustPPS <- function(spMat,X,n,beta){
    if(beta < 0) stop('beta should assume a value greater or equal to 1')
    n <- floor(n)
    N <- length(X)
    # X <- matrix(as.logical(X),N,N)
    if(N < n) stop('n is greater than population size')
    diag(spMat) <- 0 #to be sure units are not considered adjacent to themselves
    sv <- rep(FALSE,N) #vector of sampled units
    ct <- rep(FALSE,N) #vector of adjacent units

    # sv[sample(1:N, 1)] <- TRUE
    sv[sample(1:N, 1, prob=X/sum(X))] <- TRUE
    ct <- as.logical(spMat[sv,])
    Xt <- sum( (1-sv)*X )

    for(k in 2:n){
        p <- (1-sv) * (((1-ct)*X) + (ct*beta*X))
        p <- p / (Xt + (beta-1)*sum(X*ct))
        i <- sample(1:N,1,prob=p)
        sv[i] <- TRUE
        ct <- ct | X[i,]
        ct <- ct * xor(ct,sv)
        Xt <- Xt - X[i]
    }

    return(sv*1)

}
