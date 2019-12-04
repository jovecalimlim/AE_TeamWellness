library(dplyr)
library(ggplot2)
library(plotly)
library(knitr)
library(leaflet)
library(tigris)
library(reshape2)
library(scales)

osmi_2017 <- read.csv("OSMI_2017.csv", stringsAsFactors = FALSE)
osmi_2018 <- read.csv("OSMI_2018.csv", stringsAsFactors = FALSE)

osmi_2017 <- osmi_2017 %>% 
  mutate(survey_year = "2017") %>% 
  filter(country == "United States of America") %>% 
  select(age, gender, country, state, mental_disorder, survey_year,
         Anxiety.Disorder..Generalized..Social..Phobia..etc.,
         Mood.Disorder..Depression..Bipolar.Disorder..etc., 
         Psychotic.Disorder..Schizophrenia..Schizoaffective..etc., 
         Eating.Disorder..Anorexia..Bulimia..etc.,
         Attention.Deficit.Hyperactivity.Disorder, 
         Personality.Disorder..Borderline..Antisocial..Paranoid..etc.,
         Obsessive.Compulsive.Disorder,
         Post.traumatic.Stress.Disorder,
         Stress.Response.Syndromes,
         Dissociative.Disorder,
         Substance.Use.Disorder,
         Addictive.Disorder,
         Other)
         
osmi_2018 <- osmi_2018 %>% 
  mutate(survey_year = "2018") %>% 
  filter(country == "United States of America") %>% 
  select(age, gender, country, state, mental_disorder, survey_year,
         Anxiety.Disorder..Generalized..Social..Phobia..etc.,
         Mood.Disorder..Depression..Bipolar.Disorder..etc., 
         Psychotic.Disorder..Schizophrenia..Schizoaffective..etc., 
         Eating.Disorder..Anorexia..Bulimia..etc.,
         Attention.Deficit.Hyperactivity.Disorder, 
         Personality.Disorder..Borderline..Antisocial..Paranoid..etc.,
         Obsessive.Compulsive.Disorder,
         Post.traumatic.Stress.Disorder,
         Stress.Response.Syndromes,
         Dissociative.Disorder,
         Substance.Use.Disorder,
         Addictive.Disorder,
         Other)

osmi_df <- bind_rows(osmi_2017, osmi_2018)
states <- states(cb = TRUE)
colnames(osmi_df) <- c("Age", "Gender", "Country", "State", "Mental Disorder", "Survey Year",
                       "Anxiety Disorder", "Mood Disorder", "Psychotic Disorder", "Eating Disorder", 
                       "Attenion Deficit Hyperactivity Disorder", "Personality Disorder",
                       "Obsessive Compulsive Disorder", "Post Traumatic Stress Disorder", 
                       "Stress Response Disorder", "Dissociative Disorder", "Substance Use Disorder", 
                       "Addictive Disorder", "Other")

state_summ <- osmi_df %>%
  group_by(State) %>%
  summarise(yes = sum(`Mental Disorder` == "Yes"),
            no = sum(`Mental Disorder` == "No"),
            possibly = sum(`Mental Disorder` == "Possibly"),
            unsure = sum(`Mental Disorder` == "Don't Know"),
            prop = round((yes / (yes + no + possibly + unsure)), 2)
            )

states_merged <- geo_join(states, osmi_df, "STUSPS", "state")  
pal <- colorNumeric("Greens", domain = state_summ$prop)
interactive_map <- leaflet(states) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -99.62679, lat = 39.11553, zoom = 4.4) %>%
  addPolygons(data = states_merged,
              fillColor = ~pal(state_summ$prop),
              fillOpacity = 0.7,
              weight = 0.2,
              smoothFactor = 0.2,
              popup = ~paste0("State: ", NAME, "<br>Proportion: ", state_summ$prop)) %>%
  addLegend(pal = pal,
            values = state_summ$prop,
            position = "bottomright",
            title = "Proportion of Survey Respondents with Mental Illness")
  
interactive_map

disorder_by_state <- osmi_df %>% 
  group_by(State) %>%
  summarise(`Anxiety Disorder` = sum(`Anxiety Disorder` == 
                                       "Anxiety Disorder (Generalized, Social, Phobia, etc)"),
            `Mood Disorder` = sum(`Mood Disorder` == 
                                    "Mood Disorder (Depression, Bipolar Disorder, etc)"),
            `Psychotic Disorder` = sum(`Psychotic Disorder` == 
                                         "Psychotic Disorder (Schizophrenia, Schizoaffective, etc)"),
            `Eating Disorder` = sum(`Eating Disorder` == 
                                      "Eating Disorder (Anorexia, Bulimia, etc)"),
            `Attenion Deficit Hyperactivity Disorder` = sum(`Attenion Deficit Hyperactivity Disorder` == 
                                                              "Attention Deficit Hyperactivity Disorder"),
            `Personality Disorder` = sum(`Personality Disorder` == 
                                           "Personality Disorder (Borderline, Antisocial, Paranoid, etc)"),
            `Obsessive Compulsive Disorder` = sum(`Obsessive Compulsive Disorder` ==
                                                    "Obsessive-Compulsive Disorder"),
            `Post Traumatic Stress Disorder` = sum(`Post Traumatic Stress Disorder` ==
                                                     "Post-traumatic Stress Disorder"),
            `Stress Response Disorder` = sum(`Stress Response Disorder` ==
                                               "Stress Response Syndromes"),
            `Dissociative Disorder` = sum(`Dissociative Disorder` ==
                                            "Dissociative Disorder"),
            `Substance Use Disorder` = sum(`Substance Use Disorder` ==
                                             "Substance Use Disorder"),
            `Addictive Disorder` = sum(`Addictive Disorder` ==
                                         "Addictive Disorder")
            
  )

get_state_disorders <- function(given_state){
  return_plot_data <- disorder_by_state %>% 
    filter(State == given_state)
  
  return_plot_data_m <- melt(return_plot_data, id.vars = "State")
  
  return_plot <- ggplot(subset(return_plot_data_m, State == given_state), aes(x = variable, y = value)) +
    geom_bar(stat = "identity") +
    labs(x = "Disorders", y = "# of People") +
    ggtitle(paste("# of People Affected by a Specific Disorder in", given_state)) +
    scale_x_discrete(labels = wrap_format(10))
  
  return_plot
}
get_state_disorders("Texas")
