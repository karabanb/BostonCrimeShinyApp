
#### LIBRARIES ######################################################################################################### 

library(shiny)
library(tidyverse)
library(tibbletime)
library(zoo)


#### LOADING DATA ######################################################################################################

load('data/001_PreparedData.Rdata')

# Define server logic required to draw a barplote

shinyServer(function(input, output) {
  
  #### Prepraring data for reactive filtering -------------------------------------------------------------------------- 
  
  # aggregared_data   <- reactive(
  #   {prepared_data %>%
  #       as_tbl_time(OCCURRED_ON_DATE) %>%
  #       collapse_by(period = input[['period']]) %>%
  #       group_by(as.character(OCCURRED_ON_DATE), CODE_GROUP) %>%
  #       summarise(n = n()) %>%
  #       rename(period = `as.character(OCCURRED_ON_DATE)`) %>%
  #       mutate(period = ifelse(input[['period']] == 'yearly', year(period),
  #                         ifelse(input[['period']] == 'quarterly', quarter(period, with_year = TRUE),
  #                             format(period,'%Y-%m')
  #                       )
  #         )
  #       )
  #   }
  # 
  # )

  
  aggregared_data   <- reactive(
    {prepared_data %>%
        mutate(period = as.character(ifelse(input[['period']] == 'yearly', year(OCCURRED_ON_DATE),
                               ifelse(input[['period']] == 'quarterly', quarter(OCCURRED_ON_DATE, with_year = TRUE),
                                      format(OCCURRED_ON_DATE,'%Y-%m')
                                      )
                               )
               )) %>%
        group_by(period, CODE_GROUP) %>%
        summarise(n = n())
      
    }
  )
  
  #### Drawing stacked barplot -----------------------------------------------------------------------------------------
  
  output$plot_stacked <- renderPlot({
    data <- aggregared_data()
    ggplot(data, aes(period, n, fill = CODE_GROUP)) +
      geom_col(position = 'stack') +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 90))
      
    })
   
  
  #### Drawing stacked barplot -----------------------------------------------------------------------------------------
  
   output$plot_fill <- renderPlot({
     data <- aggregared_data()
     ggplot(data, aes(period, n, fill = CODE_GROUP)) +
       geom_col(position = 'fill') +
       theme_bw() +
       theme(axis.text.x = element_text(angle = 90))
     })
})

