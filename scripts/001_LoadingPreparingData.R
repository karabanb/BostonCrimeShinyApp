
#### LIBRARIES ######################################################################################################### 

library(tidyverse)
library(tibbletime)

#### LOADING DATA ######################################################################################################

raw_data <- read_csv('data/crime.csv')

preparded_data <- raw_data %>%
  mutate(OCCURRED_ON_DATE = as.Date(OCCURRED_ON_DATE),
         CODE_GROUP = fct_lump(OFFENSE_CODE_GROUP %>% as.factor, prop = 0.04),
         ) %>%
  filter(YEAR %in% c(2016, 2017), !CODE_GROUP %in% 'Other') %>%
  mutate(CODE_GROUP = fct_drop(CODE_GROUP)) %>%
  mutate_if(is.character, as.factor) %>%
  select(-INCIDENT_NUMBER, 
         -OFFENSE_CODE,
         -SHOOTING,
         -STREET,
         -Location,
         -REPORTING_AREA,
         -OFFENSE_DESCRIPTION,
         -OFFENSE_CODE_GROUP) %>%
  na.omit() %>%
  arrange(OCCURRED_ON_DATE) 

save(prepared_data, file = 'data/001_PrepraredData.Rdata')

prepared_data <- tmp %>%
  as_tbl_time(OCCURRED_ON_DATE) %>%
  collapse_by("monthly") %>%
  group_by(OCCURRED_ON_DATE, CODE_GROUP) %>%
  summarise(n = n())




ggplot(prepared_data, aes(OCCURRED_ON_DATE, n, fill = CODE_GROUP)) +
  geom_col(position = 'fill') +
  theme_bw() +
  scale_fill_viridis_d()
  
  
