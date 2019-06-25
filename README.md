# Conditional Random Sampling Sparse Matrices (CRASSMAT)

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/crassmat)](http://cran.r-project.org/package=crassmat)


## Description
This R package contains a novel matrix sampling algorithm for cross-validation procedures. It was designed for conditional random sampling observed values in sparse matrice. It is useful for training and test set splitting prior to model fitting, which allows for estimating the predictive accuracy of data imputation methods for sparse matrices, such as matrix factorization or singular value decomposition (SVD). Although designed for applications with sparse matrices, CRASSMAT can also be applied to complete matrices, as well as to those containing missing values.

## Details
CRASSMAT takes a matrix A<i>ij</i> and samples out a single <i>jth</i> value on the condition that the number of <i>jth</i> values within the <i>ith</i> observation is greater than the specified conditional (minimum number of values to remain per <i>ith</i> observation). This process repeats itself until the specified sampling threshold is met.

## Features
1. Simple implementation for training / test set splitting sparse matrices, useful in cross-validation procedures
2. Supports sparse matrices, matrices with missing values, and complete matrices
3. Supports implementation into various recommendation system settings
4. Provides a novel alternative to other matrix sampling methods <br>
(eg. Wold 'speckled style' hold-outs, Gabriel 'block style' hold-outs) 

## Installation 

```r
## load devtools 
library(devtools)

## install crassmat
devtools::install_github('nickkunz/crassmat')
```

## Usage
```r
## load crassmat
library(crassmat)

## test set
A_test <- A

## training set
A_train <- crassmat(data = A,            # matrix
                    sample_thres = 0.20, # remove 20% of observed values
                    conditional = 1)     # keep > 1 observed values per row

```
For more information, please see: [vignette](https://cran.r-project.org/web/packages/NNLM/vignettes/Fast-And-Versatile-NMF.html) on CRAN.