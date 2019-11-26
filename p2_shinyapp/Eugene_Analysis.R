library(dplyr)
library(ggplot2)
library(plotly)
library(knitr)
library(leaflet)
library(tigris)

mental_data <- read.csv("Eugene_Data_2016.csv", stringsAsFactors = FALSE)
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

states_merged <- geo_join(states, us_states, "STUSPS", "What.US.state.or.territory.do.you.live.in")  
pal <- colorNumeric("Greens", domain = affected$total_affected)
interactive_map <- leaflet(states) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -99.62679, lat = 39.11553, zoom = 4.4) %>%
  addPolygons(data = states_merged,
              fillColor = 
                ~pal(affected$total_affected),
              fillOpacity = 0.7,
              weight = 0.2,
              smoothFactor = 0.2,
              popup = ~paste0("State: ", NAME, "<br># People With Mental Illness: ", affected$total_affected)) %>%
  addLegend(pal = pal,
            values = affected$total_affected,
            position = "bottomright",
            title = "Mental Illness Present")

interactive_map
