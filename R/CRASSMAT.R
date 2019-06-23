#' @title CRASSMAT
#' @description This package includes CRASSMAT, a function for conditional random sampling observations in sparse matrices. CRASSMAT takes a given sparse matrix Aij and samples out a single jth value on the condition that the number of jth values within the ith observation is greater than the specified conditional (minimum number of values to remain per ith observation). This process repeats itself until the specified sampling threshold is met. Although CRASSMAT was designed for applications with sparse matrices, it can also be used with complete matrices or those with missing values. This package is useful for applications where sampling out observed values in a matrix is important for testing the predictive accuracy of data imputation methods, such as matrix factorization or singular value decomposition (SVD).
#' @keywords matrix matrices sampling sparse conditional random imputation
#' @aliases crassmat
#' @author Nick Kunz
#' @export crassmat
#' @param data either a sparse matrix, a complete matrix, or a matrix containing missing values
#' @param sample_thres a non-negative decimal specifying the percentage sampled out of the matrix from observed values 
#' @param conditional a non-negative integer specifying the number of observed values in matrix to remain per row
#' @return The returned object is a matrix with x number of values sampled without replacement based on the specified sampling threshold and conditional set by the user.
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
                    cat("Complete!")
                
            } ## close matrix for loop conditional statement
        } ## close matrix for loop through rows not na
        
        ## stop repeat when sampling threshold is met
        if ((mean(is.na(data_copy)) - mean(is.na(data))) / 
            mean(!is.na(data)) > sample_thres) break
        
    } ## close conditional repeat
    
    ## return sampled matrix
    return(data_copy)
    
} ## close function

## end