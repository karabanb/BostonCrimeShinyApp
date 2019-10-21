
load('data/001_PreparedData.Rdata')
c <- as.Date(preprared_data$OCCURRED_ON_DATE)

preprared_data$OCCURRED_ON_DATE <- as.Date(preprared_data$OCCURRED_ON_DATE)
preprared_data <- preprared_data %>%
  arrange(OCCURRED_ON_DATE)


prepared_data <- as_tbl_time(prepared_data, index = OCCURRED_ON_DATE)

z <- prepared_data %>%
  collapse_by('year') %>%
  group_by(OCCURRED_ON_DATE, CODE_GROUP) %>%
  summarise(occr = n()) %>%
  mutate(OCCURRED_ON_DATE = as.Date.character(OCCURRED_ON_DATE, '%YYYY'))





prepared_data %>%
  as_tbl_time(OCCURRED_ON_DATE) %>%
  collapse_by(period = x) %>%
  group_by(OCCURRED_ON_DATE, CODE_GROUP) %>%
  summarise(n = n()) %>%
  mutate(period = ifelse(x == 'yearly', year(OCCURRED_ON_DATE),
    ifelse(x == 'quarterly', quarter(OCCURRED_ON_DATE, with_year = TRUE),
      format(OCCURRED_ON_DATE, '%Y-%m')
    )
  ))
  
x <- 'yearly'

if (x == 'yearly'){
  prepared_data %>%
    mutate(periods = year(OCCURRED_ON_DATE)) %>%
    tail()
} else 
  if (x == 'monthly'){
  prepared_data %>%
    mutate(periods = month(OCCURRED_ON_DATE)) %>%
    tail()
} else {
  prepared_data %>%
    mutate(periods = quarter(OCCURRED_ON_DATE)) %>%
    tail()
}


prepared_data  %>%
  mutate(periods = ifelse(x == 'yearly', year(OCCURRED_ON_DATE) ,
                                       if_else(x== 'quarterly', quarter(OCCURRED_ON_DATE), month(OCCURRED_ON_DATE)
                                       ))) %>% tail()
  
  group_by(periods, CODE_GROUP) %>%
  summarise(n = n())
