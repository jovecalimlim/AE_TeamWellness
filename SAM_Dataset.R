library(dplyr)
library(stringr)

survey_df <- read.csv("data/MentalHealth_Survey_SAM.csv", stringsAsFactors = FALSE)
View(survey_df)

subset <- survey_df %>%
  mutate(year = substr(survey_df$Timestamp, 1, 4)) %>%
  select(-treatment, -benefits, -comments, -Timestamp)