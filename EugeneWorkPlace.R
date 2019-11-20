library(dplyr)
library(ggplot2)
library(plotly)
library(knitr)
library(leaflet)
library(tigris)

mental_data <- read.csv("data/EugeneData.csv", stringsAsFactors = FALSE)
states <- states(cb = T)

#filter for only US
us_states <- mental_data %>%
  filter(What.country.do.you.live.in == "United States of America")

#column for total affected in each state
affected <- mental_data %>%
  filter(What.country.do.you.live.in == "United States of America") %>%
  group_by(What.US.state.or.territory.do.you.live.in) %>%
  filter(Do.you.currently.have.a.mental.health.disorder == "Yes") %>%
  summarize(total_affected = n())

#Age, gender, state, role, statistics (percentage of 3 big types of disorder, willing to bring up mental health with employer, know about mental health coverage options yes/no, 

