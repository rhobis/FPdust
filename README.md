fpdust
======================================================

[![Travis-CI Build Status](https://travis-ci.org/rhobis/UPSvarApprox.svg?branch=master)](https://travis-ci.org/rhobis/UPSvarApprox)


Description 
-----------------
fpdust implements the FPDUST (Fattorini and Ridolfi, 1997) and PPS FPDUST (Barabesi et al. ,1997) Spatial Sampling Designs 
for Finite Populations. These designs draw a sample of spatial units by reducing, after each draw, the selection probability of 
units that are adjacent to any unit that have already been sampled. The PPS FPDUST sampling is a probability-proportional-to-size
sampling obtained by including a size variable in FPDUST sampling.



Installation
------------

The development version of the package can be installed from GitHub:

``` r
# if not present, install 'devtools' package
install.packages("devtools")
devtools::install_github("rhobis/fpdust")
```

Usage
-----

``` r
library(fpdust)

# List of contiguous units ---
cl <- list( c(2, 3), c(1,4), c(1,6), c(2,6), NULL, c(3,4))
# Generate spatial contingency matrix ---
cm <- spatialContingencyMatrix(cl)

### Draw a FPDUST sample ---
fpdust(cm, n= 2, beta=0.5)

### Draw a PPS FPDUST sample ---
X <- rgamma(6, 20)
fpdustPPS(cm, X, n= 2, beta=0.5)

```


More
----

- Please, report any bug or issue [here](https://github.com/rhobis/fpdust/issues).
- For more information, please contact the manteiner at `roberto.sichera@unipa.it`. 
