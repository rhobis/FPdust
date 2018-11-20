#' Select a sample from a finite population using  a modified FPDUST procedure.
#'
#' \code{fpdustPPS} selects a sample of size n from a finite population given a spatial
#' contingency matrix, a parameter \code{beta}, and a size variable vector.
#'
#' @param spMat a matrix representing spatial contingency among population units,
#'         with dimension \code{NxN} and whose values are 1's (adjacent units) or 0's (otherwisex)
#' @param X numeric vector with values of the size variable
#' @param n integer scalar representing sample size
#' @param beta a real number <1 representing a modifier of the probability of
#'             selection for units that are adjacent to already selected units
#'
#' @return a logical vector indicating which units have been selected
#'         (TRUE if selected, FALSE otherwise)
#'
#'
#' @examples
#' # List of contiguous units ---
#' cl <- list( c(2, 3), c(1,4), c(1,6), c(2,6), NULL, c(3,4))
#' # Generate spatial contingency matrix ---
#' cm <- spatialContingencyMatrix(cl)
#'
#' ### Draw a FPDUST sample ---
#' fpdust(cm, n= 2, beta=0.5)
#'
#' ### Draw a PPS FPDUST sample ---
#' X <- rgamma(6, 20)
#' fpdustPPS(cm, X, n= 2, beta=0.5)
#'
#'
#' @export




fpdustPPS <- function(spMat,X,n,beta){


    ## Check input
    if(!is.matrix(spMat)) stop("Argument spMat should be anobject of class matrix!")
    if(ncol(spMat) != nrow(spMat)) stop("spMat should be a square matrix!")
    if( !is.atomic(n)) stop("Argument n must be a numeric scalar")
    if( !is.numeric(n) ) stop("Argument n must be numeric!")
    if( n<2) stop("The sample size n should be >=2")
    if( beta>1) stop("The parameter beta should be <1")
    if( !is.numeric(X) | !is.vector(X) ) stop("Argument X should be a numeric vector!")


    if(beta < 0) stop('beta should assume a value greater or equal to 0')
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
        p <- (1-sv) * (((1-ct)*X) + (ct*(1-beta)*X))
        p <- p / (Xt + (beta)*sum(X*ct))
        i <- sample(1:N,1,prob=p)
        sv[i] <- TRUE
        ct <- ct | spMat[i,]
        ct <- ct * xor(ct,sv)
        Xt <- Xt - X[i]
    }

    return(sv)

}
