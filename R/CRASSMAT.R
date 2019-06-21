#' @title CRASSMAT
#' @description This package includes CRASSMAT, a function for conditional random sampling out observations in sparse matrices. CRASSMAT takes a given sparse matrix Aij and samples out a single jth value on the condition that the number of jth values within the ith observation is greater than the specified conditional (minimum number of values to remain per ith observation). This process repeats itself until the specified sampling threshold is met. Although CRASSMAT was designed for applications with sparse matrices, it can also be applied to complete matrices or those with missing values. This package is useful for applications where sampling out observed values in a matrix is important for testing the predictive accuracy of data imputation methods, such as matrix factorization or singular value decomposition (SVD).
#' @keywords matrix, matrix sampling, sparse matrix, conditional random sampling, matrix factorization, svd sampling
#'
#' @param sparse_matrix data
#' @param test_split_thres percent sampled out of matrix from observed values
#' @param conditional number of observed values in matrix to remain per row
#'
#' @return sampled matrix
#'
#' @examples 
#' ## crassmat example
#' A_training <- crassmat(sparse_matrix = A,
#'                        test_split_thres = 0.20,
#'                        conditional = 1)
#'
#' @export crassmat

## title: CRASSMAT
## description: conditional random sampling for sprase matrices
## author: nick kunz <nick.kunz@columbia.edu>
## created: 04/22/2019
## updated: 06/20/2019
## dependencies: svMisc

## create crassmat
crassmat <- function(sparse_matrix, test_split_thres, conditional) {
    
    ## duplicate original matrix (test set)
    sparse_matrix_copy <- sparse_matrix
    
    ## install / load progress tracking dependent library
    if (!require("svMisc"))  
        install.packages("svMisc")
    
    ## conditional repeat
    repeat {
        
        ## conditional sampling for loop
        for (i in 0:nrow(sparse_matrix_copy)) {  ## loop through rows not na
            if (length(which(!is.na(sparse_matrix_copy[i, ]))) > conditional) {  ## conditional statement
                
                ## conduct single sample removal for rows that meet conditional
                sparse_matrix_copy[i, ][sample(which(!is.na(sparse_matrix_copy[i, ])), size = 1)] <- NA

                ## conduct progress tracking by percentage 
                svMisc::progress(i / nrow(sparse_matrix_copy) * 100)
                
                ## print prompt when completed
                if(i == nrow(sparse_matrix_copy)) 
                    cat("Complete!")
                
            } ## close matrix for loop conditional statement
        } ## close matrix for loop through rows not na
        
        ## stop repeat when sampling threshold is met
        if ((mean(is.na(sparse_matrix_copy)) - mean(is.na(sparse_matrix))) / 
            mean(!is.na(sparse_matrix)) > test_split_thres) break
        
    } ## close conditional repeat
    
    ## return sampled matrix
    return(sparse_matrix_copy)
    
} ## close function

## end