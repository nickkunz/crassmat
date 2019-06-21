## title: CRASSMAT
## description: data set for CRASSMAT demo
## author: nick kunz <nick.kunz@columbia.edu>
## created: 04/22/2019
## updated: 06/20/2019
## dependencies: svMisc

## create matrix
n <- 3000;
m <- 15;
k <- 3;
W  <- matrix(runif(n * k),  n, k);
H  <- matrix(10 * runif(k * m),  k, m);
noise <- matrix(rnorm(n * m), n, m);
A <- W %*% H + noise;
A[A < 0] <- 0;

## create sparsity
set.seed(1234);                                                  # set random number
sparse_sample <- 0.85 * length(A);                               # sparsity percentage
sparse_index <- sample(which(!is.na(A)), size = sparse_sample);  # create sparse matrix
A[sparse_index] <- NA;                                           # remove matrix values 
rm(n, m, k, W, H, noise, sparse_sample, sparse_index)            # remove toy matrix components

## end