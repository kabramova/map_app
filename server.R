library(shiny)
library(ggplot2)
library(reshape2)

# Define server logic required to draw a histogram

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
    xname <-rep("x=", num_xs)
    x <- as.character(initConds)
    colnames(all_values) <- paste(xname, x, sep="")
    all_values$t <- 0:(N-1)
    all_values
}

extractNums <- function(string){
    unlist(regmatches(string,gregexpr("[[:digit:]]+\\.*[[:digit:]]*",string)), 
           use.names=FALSE)
} 

shinyServer(function(input, output) {
    
    # Expression that generates a histogram. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should re-execute automatically
    #     when inputs change
    #  2) Its output type is a plot
    
    output$distPlot <- renderPlot({
        initConds <- as.numeric(extractNums(input$initConds))
        time_series <- getValues(input$r, input$N, initConds)
        toplot <- melt(time_series, id="t")
        
        # draw the histogram with the specified number of bins
        ggplot(toplot, aes(x=t, y=value, color=variable)) + geom_line() + 
            geom_point() + xlim(0, input$N) + ylim(0,1) + ylab("value") +
            theme(plot.title = element_text(size = 20), 
                  axis.title = element_text(size=16),
                  axis.text = element_text(size=12),
                  legend.position = "top",
                  legend.title = element_text(size=14),
                  legend.text = element_text(size=14)) +
            scale_colour_discrete(name = "Initial conditions:")
    })    
})