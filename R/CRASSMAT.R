#' @title Conditional Random Sampling Sparse Matrices
#' @description Conducts conditional random sampling on observed values in sparse matrices. Useful for training and test set splitting sparse matrices prior to model fitting in cross-validation procedures and estimating the predictive accuracy of data imputation methods, such as matrix factorization or singular value decomposition (SVD). Although designed for applications with sparse matrices, CRASSMAT can also be applied to complete matrices, as well as to those containing missing values.
#' @aliases crassmat
#' @details Takes a matrix A\emph{ij} and samples out a single \emph{jth} value on the condition that the number of \emph{jth} values within the \emph{ith} observation is greater than the specified conditional (minimum number of values to remain per \emph{ith} observation). This process repeats itself until the specified sampling threshold is met.
#' @keywords matrix matrices sampling sparse conditional random imputation
#' @author Nick Kunz <\email{nick.kunz@columbia.edu}>
#' @export crassmat
#' @param data a matrix (supports sparsity, missing values, and complete matrices)
#' @param sample_thres a non-negative decimal specifying the percentage of observed values sampled out
#' @param conditional a non-negative integer specifying the number of observed values to remain per row
#' @return Returns a matrix object with observed values removed according to the specified \code{sample_thres} and \code{conditional}.
#' @references Kunz, N. (2019). \emph{Unsupervised Learning for Submarket Modeling: A Proxy for Neighborhood Change} (Master's Thesis). Columbia University, New York, NY.
#' @examples
#' ## test set
#' A_test <- A
#' 
#' ## training set
#' A_train <- crassmat(data = A,            # matrix
#'                     sample_thres = 0.20, # remove 20% of observed values
#'                     conditional = 1)     # keep > 1 observed values per row
## create crassmat
crassmat <- function(data, sample_thres, conditional) {
    
    ## duplicate original matrix (test set)
    data_copy <- data
    
    ## conditional repeat
    repeat {
        
        ## conditional sampling for loop
        for (i in 0:nrow(data_copy)) {  ## loop through rows not na
            if (length(which(!is.na(data_copy[i, ]))) > conditional) {  ## conditional statement
                
                ## conduct single sample removal for rows that meet conditional
                data_copy[i, ][sample(which(!is.na(data_copy[i, ])), size = 1)] <- NA

                ## conduct progress tracking by percentage 
                svMisc::progress(i / nrow(data_copy) * 100)
                
                ## print prompt when completed
                if(i == nrow(data_copy)) 
                    message("Complete!")
                
            } ## close matrix for loop conditional statement
        } ## close matrix for loop through rows not na
        
        ## stop repeat when sampling threshold is met
        if ((mean(is.na(data_copy)) - mean(is.na(data))) / 
            mean(!is.na(data)) > sample_thres) break
        
    } ## close conditional repeat
    
    ## return sampled matrix
    return(data_copy)
    
} ## close function
