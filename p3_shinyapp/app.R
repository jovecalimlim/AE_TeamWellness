#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Initial library/source files set-up
library(shiny)
source("analysis.R")

# Pages 1-7 instantiated and structured for use
page_one <- tabPanel(
  "Introduction",
  titlePanel("Mental Health In The Technology Workplace"),
  
  h3("The Problem Situation"),
  p("Mental health has become an increasingly hot issue in the workplace. The mental health of employees 
    is being negatively impacted by numerous factors within the workplace. Due to this, there is an 
    increased strain on worker's and their performance, which is also negatively affecting company results. 
    Currently, mental health is a stigmatized topic in the workplace, and as such, is an area of high 
    confidentiality between employees and employers."),
  
  h3("What is the Problem?"),
  p("Approximately half of millennial workers and 75% of Gen-Zers have quit their jobs due to mental 
    health reasons according to a survey conducted by Mind Share Partners, SAP, and Qualtrics. About 
    46.6 million US adults are dealing with mental illnesses, including depression and anxiety disorders. 
    The main factors contributing to this is money, work load, and a negative working environment.")
)

page_two <- tabPanel(
  "Background",
  titlePanel("Why This Topic And What We Hope To Find"),
  
  h3("Why we care about Mental Health"),
  p("Our group cares about this topic because we have heard of first-hand accounts of employees 
    cracking under intense stress within tech companies like Amazon, and as young Informatics 
    majors looking to go into the tech field, we want to help improve the environment we go into 
    not just for ourselves, but for everyone."),
  
  h3("What we Hope to Answer"),
  tags$li("Which states in the US seem to have a higher proportion of their tech workers 
          affected by mental illnesses compared to other states?"), 
  tags$li("Within each state, what mental health illnesses/disorders are people in the tech field 
          dealing with?")
)

page_three <- tabPanel(
  "Interactive Map",
  titlePanel("Prevalence Of Mental Disorders Throughout The United States"),
  interactive_map,
  p("WIth our interactive map, we actually get some suprising results. New Hampshire has the highest
    proportion of people who took the survey living in New Hampshire that reported being affected
    by mental illnesses/disorders at 86%. Kentucky and Alaska follow close behind at 80% and 77%
    respectively. We we're expected tech company-heavy states such as California and Washington to
    have the highest proportion. Of course, this could be due to the relatively small sample size of
    survey respondents, as there are only a total of about 800 survey respondents within the United
    States. Still, over half of the survey respondents in both Washington and California reported
    being affected by mental illnesses/disorders, which is a very significant amount of people.")
)

page_four <- tabPanel(
  "Bar Charts",
  titlePanel("Mental Disorders By State"),
  sidebarLayout(
    sidebarPanel(
      selectInput("summ_state", "State:",
                  choices = sort(unique(osmi_df$State)),
                  selected = "Washington")
    ),
    mainPanel(
      plotOutput("statePlot")
    )
  ),
  p("From these bar charts, we can see that for most states, anxiety and mood disorders are the most
    common mental disorders that are plaguing tech workers in the United States. For example, in the
    state of Washington, the top two most common mental disorders are mood disorders such as depression
    and bipolar disorder with 25 affected survey respondents. Anxiety disorders such as social anxiety
    and phobias are second with 17 affected survey respondents.")
)

page_five <- tabPanel(
  "Conclusion",
  titlePanel("What We Found"),
  
  h3("Results"),
  p("With the data sets that we worked with and the visualizations we were able to create, we we're
    able to answer our research questions to an extent. The sample sizes weren't quite as large as we'd
    like, and it's very important to realize that. But we we're still able to gather some valuable insights
    into how widespread mental health is in the United States within the tech industry. There are a variety
    of mental disorders that are affecting workers, with some of the more common ones being various forms of
    anxiety such as social anxiety, generalized anxiety, and panic disorders, or various forms of mood
    disorders such as depression, bipolar disorder, and dysthymia. But there are tech workers that are
    experiencing other types of disorders, like attention deficit hyperactivity disorder and post
    traumatic stress disorder."),
  p("Despite the somewhat low number of responses between the two data sets of the OSMI survey, we can see
    that mental health is impacting tech employees in most states except Nevada, Missouri, Iowa, 
    Indiana, Tennesse, Georgia, Ohio, West Virginia, Maryland, and Virginia. That is most likely due to
    the low number of survey responses, as I imagine there companies/offices in these states that have some
    form of IT/engineering/software development departments. As mentioned earlier, we we're expecting
    tech company-heavy states such as Washington, California and New York to be at the top of our charts
    for the proportion of tech workers surveyed in those states that are dealing with a mental illness/
    disorder.")
)

page_six <- tabPanel(
  "Technical Info",
  titlePanel("Technical Specifications"),
  
  h3("The Data Sets"),
  p("The two data sets we used were created by a non-profit organization called Open Sourcing Mental Illness. 
    Their mission is \"to raise awareness, educate, and provide resources to support mental wellness 
    in the tech and open source communities\". This data is gathered through a yearly
    survey that OSMI conducts, and then compiles these survey results into data sets. These data sets 
    were created to help OSMI with their research in finding out what factors within tech and open source 
    communities have an effect on someone's mental health. We accessed this data through OSMI's official 
    website, where they host their data sets on Kaggle, free and available for anyone to use."),
  
  h3("The Shiny App"),
  p("With the help of a7, we we're able to create a Shiny app similar to how we structured a7. To create
    the Shiny app's site navigation, we decided to use a navbarPage() layout that allowed us to insert
    different page layouts and have an easy way to navigate in between. For our second visualization,
    we made sure to use a sidebarLayout() to have our charts render on the right and have the widgets
    that allow the user to select states on the left."),
  p("We also used a variety of packages to help wrangle our data and create the visualizations. We
    primarily used dplyr to wrangle that data and organize it into usuable data frames containing
    relevant information for the task at hand. We used ggplot2, reshape2, and scales to create the 
    bar charts used for our second visualization. We used knitr, leaflet, and tigris to create the
    map used for our first visualization."),
  
  h3("Tech Report"),
  p(a(href= "https://github.com/jovecalimlim/AE_TeamWellness/wiki/Technical-Report", 
      "Here is the link to our Technical Report on GitHub.")),
)

page_seven <- tabPanel(
  "About Us",
  titlePanel("Who We Are"),
  HTML(
    paste("Ryan Bogatez",
          "Jove Calimlim",
          "Samuel Christ: I’m an international student from Indonesia and just transferred from Edmonds Community College.
I am also a content creator on YouTube with more than 900K subscribers!
I enjoy creating short films and editing videos. 
I’m very glad I can get into the Informatics major because there are a lot of designing classes in this major and that is what I want to do.
Regarding to my skills, I think I am a creative person, can think in details and can do design.",
          "Eugene Lim", sep = "<br/>"
    )
  ),
)

# UI pages set in navbarPage style
ui <- navbarPage(
  "P3: Final Project",
  page_one,
  page_two,
  navbarMenu("Visualizations",
             page_three,
             page_four
  ),
  page_five,
  page_six,
  page_seven
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$statePlot <- renderPlot({
    get_state_disorders(input$summ_state)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
