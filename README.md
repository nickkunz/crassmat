<div align="center">
  <img src="https://github.com/nickkunz/crassmat/blob/master/media/crassmat_banner.png">
</div>

# Conditional Random Sampling Sparse Matrices

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/crassmat)](https://cran.r-project.org/package=crassmat) 
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Build Status](https://travis-ci.org/nickkunz/crassmat.svg?branch=master)](https://travis-ci.org/nickkunz/crassmat)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f05cad864ada41d3b31a777348479666)](https://www.codacy.com/manual/nickkunz/crassmat?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nickkunz/crassmat&amp;utm_campaign=Badge_Grade)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/nickkunz/crassmat/master.svg)](https://github.com/nickkunz/crassmat)

## Description
This R package contains a novel matrix sampling algorithm. Conducts conditional random sampling on observed values in sparse matrices. Useful for training and test set splitting sparse matrices prior to model fitting in cross-validation procedures and for estimating the predictive accuracy of data imputation methods, such as matrix factorization or singular value decomposition (SVD). Although designed for applications with sparse matrices, CRASSMAT can also be applied to complete matrices, as well as to those containing missing values.

## Details
CRASSMAT takes a matrix A<i>ij</i> and samples out a single <i>jth</i> value on the condition that the number of <i>jth</i> values within the <i>ith</i> observation is greater than the specified conditional (minimum number of values to remain per <i>ith</i> observation). This process repeats itself until the specified sampling threshold is met.

## Features
1. Simple implementation for data splitting sparse matrices, useful in cross-validation procedures
2. Supports sparse matrices, matrices with missing values, and complete matrices
3. Supports implementation into various recommendation system settings
4. Provides a novel alternative to other matrix sampling methods <br>
(eg. Wold 'speckled style' hold-outs, Gabriel 'block style' hold-outs) 

## Installation
```r
## install CRAN release
install.packages('crassmat')

## install developer version
library(devtools)
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
## License

© Nick Kunz, 2019. Licensed under the General Public License v3.0 (GPLv3).

## Contributions

CRASSMAT is open for improvements and maintenence. Your help is valued to make the package better for everyone.

## References

Kunz, N. (2019). <i>Unsupervised Learning for Submarket Modeling: A Proxy for Neighborhood Change</i> (Master’s Thesis). Columbia University, New York, NY. https://doi.org/10.7916/d8-rj87-yx32.

Kunz, N. (2019). <i>CRASSMAT: Conditional Random Sampling Sparse Matrices</i>. The Comprehensive R Archive Network (CRAN). https://cran.r-project.org/web/packages/crassmat/index.html.
