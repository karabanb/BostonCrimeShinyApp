
load('data/001_PreparedData.Rdata')
c <- as.Date(preprared_data$OCCURRED_ON_DATE)

preprared_data$OCCURRED_ON_DATE <- as.Date(preprared_data$OCCURRED_ON_DATE)
preprared_data <- preprared_data %>%
  arrange(OCCURRED_ON_DATE)


preprared_data <- as_tbl_time(preprared_data, index = OCCURRED_ON_DATE)

z <- preprared_data %>%
  collapse_by('year') %>%
  group_by(OCCURRED_ON_DATE, OFFENSE_CODE_GROUP) %>%
  summarise(occr = n())
  