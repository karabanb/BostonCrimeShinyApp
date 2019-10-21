
#### LIBRARIES ######################################################################################################### 

library(shiny)
library(shinydashboard)
library(tidyverse)


#### DEFINING DASHBOARD'S CONTENT ######################################################################################


# Define UI for application that draws a barplots

sidebar <- dashboardSidebar(
    radioButtons("period",
                 "Choose period:",
                 choices = c('Year' = 'yearly', 'Quarter' = 'quarterly', 'Month' = 'monthly'),
                 selected = 'monthly')
)


body <- dashboardBody(
    fluidRow(box(plotOutput('plot_stacked'),width = 12, collapsible = TRUE)),
    fluidRow(box(plotOutput("plot_fill"), width = 12, collapsible = TRUE))
    
)


ui <- dashboardPage(
    header = dashboardHeader(title = 'Boston Cirme Dashboard'),
    sidebar = sidebar,
    body = body
)

