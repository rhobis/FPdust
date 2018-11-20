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

More
----

- Please, report any bug or issue [here](https://github.com/rhobis/robustHT/issues).
- For more information, please contact the manteiner at `roberto.sichera@unipa.it`. 
