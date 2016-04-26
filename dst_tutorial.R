library(ggplot2)
library(reshape2)

getValues <- function(r, N, initConds) {
    ## r: bifurcation parameter
    ## N: Number of iteration
    ## initConds: initial values
    ## Logistic equation is: f(x) = rx(1-x)
    N <- N+1
    num_xs <- length(initConds)
    all_values = data.frame(matrix(NA, nrow = N, ncol = num_xs))
    for (i in c(1:num_xs)){
        values <- 1:N
        values[1] <- initConds[i]
        for (j in c(1:(N-1))) {
            values[j+1] <- r * values[j] * (1 - values[j])
        }
        all_values[i] <- values
    }
    xname <-rep("x", num_xs)
    x <- as.character(c(1:num_xs))
    colnames(all_values) <- paste(xname, x, sep="")
    all_values$t <- 0:(N-1)
    all_values
}


logisticMap <- function(r, N, initConds) {
    time_series <- getValues(r, N, initConds)
    toplot <- melt(time_series, id="t")
    
    p <- ggplot(toplot, aes(x=t, y=value, color=variable)) + geom_line() + 
        geom_point() + xlim(0, N) + ylim(0,1) + ylab("value")
    print(p)
}


