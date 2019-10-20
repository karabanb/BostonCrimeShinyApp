
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
  
  cleaned_data <- reactive({if (input$period == 'yearly'){
    prepared_data %>%
      mutate(periods = format(OCCURRED_ON_DATE, '%Y'))
  } else {
    if (input$period == 'monthly'){
      prepared_data %>%
        mutate(periods = format(OCCURRED_ON_DATE, '%Y-%m'))
    }
    else {
      prepared_data %>%
        mutate(periods = paste(format(OCCURRED_ON_DATE, '%Y'),quarters(OCCURRED_ON_DATE)))
    }
  }
  }
  )
  
  
  
  aggregated_data <- reactive({
    cleaned_data() %>%
      group_by(periods, CODE_GROUP) %>%
      summarise(n = n())
  }
)
  
  #### Drawing stacked barplot -----------------------------------------------------------------------------------------
  
  output$plot_stacked <- renderPlot({
    data <- aggregated_data()
    ggplot(data, aes(periods, n, fill = CODE_GROUP)) +
      geom_col(position = 'stack') +
      theme_bw() +
      labs(y = 'n') +
      theme(axis.text.x = element_text(angle = 90))
      
    })
   
  
  #### Drawing stacked barplot -----------------------------------------------------------------------------------------
  
   output$plot_fill <- renderPlot({
     data <- aggregated_data()
     ggplot(data, aes(periods, n, fill = CODE_GROUP)) +
       geom_col(position = 'fill') +
       theme_bw() +
       labs(y = '%') +
       theme(axis.text.x = element_text(angle = 90))
     })
})
