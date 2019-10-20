
#### LIBRARIES ######################################################################################################### 

library(shiny)
library(shinydashboard)
library(tidyverse)
library(tibbletime)


#### DEFINING DASHBOARD'S CONTENT ######################################################################################


# Define UI for application that draws a barplots

sidebar <- dashboardSidebar(
    radioButtons("period",
                 "Choose period:",
                 choices = c('Year' = 'yearly', 'Quarter' = 'quarterly', 'Month' = 'monthly'),
                 selected = 'monthly')
)


body <- dashboardBody(
    plotOutput('plot_stacked'),
    plotOutput("plot_fill")
    
)


ui <- dashboardPage(
    header = dashboardHeader(),
    sidebar = sidebar,
    body = body
)

