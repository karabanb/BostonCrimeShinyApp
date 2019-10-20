
#### LIBRARIES ######################################################################################################### 

library(shiny)
library(tidyverse)
library(tibbletime)

#### LOADING DATA ######################################################################################################

load('data/001_PreparedData.Rdata')

# Define server logic required to draw a barplote

shinyServer(function(input, output) {
  
  #### Prepraring data for reactive filtering -------------------------------------------------------------------------- 
  
  aggregared_data   <- reactive(
    {prepared_data %>%
        as_tbl_time(OCCURRED_ON_DATE) %>%
        collapse_by(period = input[['period']]) %>%
        group_by(as.character(OCCURRED_ON_DATE), CODE_GROUP) %>%
        summarise(n = n()) %>%
        rename(period = `as.character(OCCURRED_ON_DATE)`)}
  )

  
  #### Drawing stacked barplot -----------------------------------------------------------------------------------------
  
  output$plot_stacked <- renderPlot({
    data <- aggregared_data()
    ggplot(data, aes(period, n, fill = CODE_GROUP)) +
      geom_col(position = 'stack') +
      theme_bw()
    })
   
  
  #### Drawing stacked barplot -----------------------------------------------------------------------------------------
  
   output$plot_fill <- renderPlot({
     data <- aggregared_data()
     ggplot(data, aes(period, n, fill = CODE_GROUP)) +
       geom_col(position = 'fill') +
       theme_bw()
     })
})

