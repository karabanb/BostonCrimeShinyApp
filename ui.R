
#### LIBRARIES ######################################################################################################### 

library(shiny)
library(tidyverse)
library(tibbletime)


#### LOADING DATA ######################################################################################################



# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Chicago Crime Dashboard"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("period",
                        "Choose period:",
                        choices = c('Year' = 'yearly', 'Quarter' = 'quarterly', 'Month' = 'monthly'),
                        selected = 'monthly')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput('plot_stacked'),
            plotOutput("plot_fill")
        )
    )
))
