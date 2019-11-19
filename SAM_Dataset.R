library(dplyr)
library(stringr)
library(ggplot2)

survey_df <- read.csv("data/MentalHealth_Survey_SAM.csv", stringsAsFactors = FALSE)
View(survey_df)

subset <- survey_df %>%
  mutate(year = substr(survey_df$Timestamp, 1, 4)) %>%
  select(-treatment, -benefits, -comments, -Timestamp, -mental_health_consequence, -phys_health_consequence, -work_interfere, -mental_vs_physical, -obs_consequence, -leave, -anonymity)

#count the number of people who work in tech company
nrow(filter(subset, tech_company == "Yes"))

#count the number of people who work in tech company
nrow(filter(subset, tech_company == "No"))

#count the number of person from each states
subset %>%
  group_by(state) %>%
  summarise(count=n()) %>%
  arrange(count)

#count the number of person from each country they are from
Num_country <- subset %>%
  group_by(Country) %>%
  summarise(count=n()) %>%
  arrange(count)

#categorized number of workers
subset %>%
  group_by(no_employees) %>%
  summarise(count=n()) %>%
  arrange(count)

#Count how many people work remotely (outside of an office) at least 50% of the time
subset %>%
  group_by(remote_work) %>%
  summarise(count=n()) %>%
  arrange(count)

#Count the number of people in every ages.
subset %>%
  group_by(Age) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people in each gender
Num_Gender <- subset %>%
  group_by(Gender) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people that know the employers provide a care option
subset %>%
  group_by(care_options) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people that know about the wellness program.
subset %>%
  group_by(wellness_program) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people that their employer provide resources
# to learn more about mental health issues and how to seek help.
subset %>%
  group_by(seek_help) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people who have a family history of mental illness.
subset %>%
  group_by(family_history) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people that think discussing a mental health
#issue with your employer would have negative consequences.
subset %>%
  group_by(mental_health_consequence) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people that willing to discuss a mental health issue with their coworkers.
subset %>%
  group_by(coworkers) %>%
  summarise(count=n()) %>%
  arrange(-count)

#count the number of people that willing to discuss a mental health issue with their supervisor.
subset %>%
  group_by(supervisor) %>%
  summarise(count=n()) %>%
  arrange(-count)

#The data count the number of people that want to bring up
#a mental health issue with a potential employer in an interview.
subset %>%
  group_by(mental_health_interview) %>%
  summarise(count=n()) %>%
  arrange(-count)

#The data count the number of people that want to bring up
#a physical health issue with a potential employer in an interview.
subset %>%
  group_by(phys_health_interview) %>%
  summarise(count=n()) %>%
  arrange(-count)

#summarize the data
subset_1 <- subset %>%
  group_by(supervisor) %>%
  summarize(
    count=n()
  )

#make the order yes, no and some of them.
subset_1$supervisor <- factor(subset_1$supervisor, levels = c("Yes", "No", "Some of them"))

#make the bar chart
plot <- ggplot(subset_1, aes(x = supervisor, y = count)) +
  geom_col()
