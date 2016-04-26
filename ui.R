library(shiny)

# Define UI for application that draws a histogram
# Shiny ui.R scripts use the function fluidPage to create a display that automatically adjusts to the dimensions of your user’s browser window. You lay out your app by placing elements in the fluidPage function.

shinyUI(fluidPage(
    # titlePanel and sidebarLayout are the two most popular elements to add to fluidPage.
    # They create a basic Shiny app with a sidebar.    
    
    # Application title
    titlePanel("Logistic Map: f(x) = Rx(1-x)"),
    br(),
    
    # Sidebar with a slider input
    # sidebarLayout always takes two arguments: sidebarPanel function output, mainPanel function output
    
    sidebarLayout(position="left",
        sidebarPanel(
            h3("Pick your parameters:"),
            br(),
            sliderInput("r",
                        label="Parameter R:",
                        min = 0,
                        max = 4,
                        value = 2,
                        step = 0.1),
            sliderInput("N",
                        label="Number of time points:",
                        min = 1,
                        max = 50,
                        value = 10),
            textInput("initConds",
                      label="Initial condition(s):",
                      value = "0.2, 0.6",
                      placeholder = "0.2, 0.6")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h3("Time series plot"),
            plotOutput("distPlot"),
            br(),
            h3("Bifurcation diagram"),
            img(src="bifurcation.png", height = 400, width = 600, align="right")
        )
    )
))