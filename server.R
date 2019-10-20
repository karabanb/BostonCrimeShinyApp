
#### LIBRARIES ######################################################################################################### 

library(shiny)
library(tidyverse)
library(tibbletime)

#### LOADING DATA ######################################################################################################

load('data/001_PreparedData.Rdata')

# Define server logic required to draw a histogram

shinyServer(function(input, output) {
  
  aggregared_data   <- reactive(
    {prepared_data %>%
        as_tbl_time(OCCURRED_ON_DATE) %>%
        collapse_by(period = input[['period']]) %>%
        group_by(as.character(OCCURRED_ON_DATE), CODE_GROUP) %>%
        summarise(n = n()) %>%
        rename(period = `as.character(OCCURRED_ON_DATE)`)}
  )

  output$plot_stacked <- renderPlot({
    data <- aggregared_data()
    ggplot(data, aes(period, n, fill = CODE_GROUP)) +
      geom_col(position = 'stack') +
      theme_bw()
    })
   
   output$plot_fill <- renderPlot({
     data <- aggregared_data()
     ggplot(data, aes(period, n, fill = CODE_GROUP)) +
       geom_col(position = 'fill') +
       theme_bw()
})
})

