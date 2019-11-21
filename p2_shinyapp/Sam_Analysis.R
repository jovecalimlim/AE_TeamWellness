library(dplyr)
library(stringr)
library(ggplot2)
library(forcats)

survey_df <- read.csv("../data/Sam_Data_2014.csv", stringsAsFactors = FALSE)

# Count the number of person from each country they are from
people_per_country <- survey_df %>%
  group_by(Country) %>%
  summarise(count=n()) %>%
  arrange(count)

us_only_survey_df <- survey_df %>%
  mutate(year = substr(survey_df$Timestamp, 1, 4)) %>%
  filter(Country == "United States") %>% 
  select(-treatment, -benefits, -comments, -Timestamp, -mental_health_consequence, 
         -phys_health_consequence, -work_interfere, -mental_vs_physical, -obs_consequence, 
         -leave, -anonymity)

# Count the number of people who work in tech companies
num_tech_workers <- nrow(filter(us_only_survey_df, tech_company == "Yes"))
num_tech_workers

# Count the number of people who do not work in tech companies
num_nontech_workers <- nrow(filter(us_only_survey_df, tech_company == "No"))
num_nontech_workers

# Count the number of person from each states
people_per_state <- us_only_survey_df %>%
  group_by(state) %>%
  summarise(count=n()) %>%
  arrange(count)

# Categorized number of workers
num_companies_per_size <- us_only_survey_df %>%
  group_by(no_employees) %>%
  summarise(count=n()) %>%
  arrange(count)

# Count how many people work remotely (outside of an office) at least 50% of the time
num_remote_workers <- us_only_survey_df %>%
  group_by(remote_work) %>%
  summarise(count=n()) %>%
  arrange(count)

# Count the number of people in every ages.
#us_only_survey_df$Age_Group <-cut(us_only_survey_df$Age, breaks = seq(15,85,by=10), right = TRUE)
#num_people_per_age <- us_only_survey_df %>%
#  group_by(Age_Group) %>%
#  count(Age_Group)

# Count the number of people in each gender
num_Gender <- us_only_survey_df %>%
  group_by(Gender) %>%
  summarise(count=n()) %>%
  arrange(-count)

# Would you bring up a mental health issue with a potential employer in an interview?
response_to_ment_interview <- us_only_survey_df %>%
  group_by(mental_health_interview) %>%
  summarise(count=n()) %>%
  mutate(mental_health_interview = factor(mental_health_interview, levels = c("Yes", "No", "Maybe")))

# Bar Chart for the above question
ment_interview_plot <- ggplot(data = response_to_ment_interview) +
  geom_col(mapping = aes(x = mental_health_interview, y = count))
ment_interview_plot

# Would you bring up a physical health issue with a potential employer in an interview?
response_to_phys_interview <- us_only_survey_df %>%
  group_by(phys_health_interview) %>%
  summarise(count=n()) %>%
  mutate(phys_health_interview = factor(phys_health_interview, levels = c("Yes", "No", "Maybe")))

# Bar Chart for the above question
phys_interview_plot <- ggplot(data = response_to_phys_interview) +
  geom_col(mapping = aes(x = phys_health_interview, y = count))
phys_interview_plot

# Would you be willing to discuss a mental health issue with your direct supervisor(s)?
response_to_supervisor <- us_only_survey_df %>%
  group_by(supervisor) %>%
  summarize(count=n()) %>% 
  mutate(supervisor = factor(supervisor, levels = c("Yes", "No", "Some of them")))

# Bar Chart for the above question
supervisor_plot <- ggplot(data = response_to_supervisor) +
  geom_col(mapping = aes(x = supervisor, y = count))
supervisor_plot
