#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
source("analysis.R")

# UI elements
page_one <- tabPanel(
    "About",
    titlePanel("a7: ProPublica Congress API"),
    
    h2("Overview"),
    p("This assignment has us creating and deploying a Shiny app that gives our users the ability
      to look at detailed information about every member of the United States House of Representatives.
      To access this information, we have been tasked with using ProPublica's Congress API to pull
      information about members of the Unied State's Congress."),
    p("To complete this assignment, I will be using R to interact with ProPublica's Congress API to
      build a data frame containing all members of Congress and only keeping the columns that are 
      relevant for displaying information within my Shiny app. From my Shiny app, you will be able
      to view tables of the different states' House representatives, and see how each states' House
      is broken up by gender and political party."),
    p(a(href= "https://projects.propublica.org/api-docs/congress-api/", 
        "Here is the link to ProPublica's Congress Api.")),
    
    h2("Affiliation"),
    HTML(
        paste("Jove Calimlim",
              "INFO-201A: Technical Foundations of Informatics",
              "The Information School",
              "University of Washington",
              "Autumn 2019", sep = "<br/>"
        )
    ),
    
    h2("Reflection"),
    p("I thought working on this assignment gave me a good understanding of how Shiny apps work
      and how I'd be able to use the features of Shiny apps to produce a meaningful and effective
      way for users to interact with data in an easy and intuitive manner. Prior to taking this class,
      I had no idea about the R language or data visualization tools but after working on a7 for awhile,
      I now have a greater appreciation for the tools that we have available to us as data scientists to
      make data more visibly appealing and understandable for the average person."),
    p("But as always when working with data, you should always be vigiliant in making sure your data sets
      that you use for any analysis is as valid and accurate as possible. There's no such thing as a perfect 
      data with no bias, but reducing bias as much as possible whenever you gather data or making sure your 
      sources are as transparent as possible helps battle an issue from O'Neil's Weapons of Math Destruction.
      One issue O'Neil took with WMD's is that many of them used proxy data as stand-ins for data/metrics
      that actually mean something. For example, personality tests being used to determine if a job
      applicant would be fit for a position."
    )
)

page_two <- tabPanel(
    "Congress Table",
    titlePanel("Congress Members by Chamber and State"),
    sidebarLayout(
        sidebarPanel(
            selectInput("chamber", "Chamber:",
                        choices = sort(unique(congress_df$chamber)),
                        selected = "house"),
            selectInput("state", "State:",
                        choices = sort(unique(congress_df$state)),
                        selected = "WA")
        ),
        mainPanel(
            dataTableOutput("stateRepsTable"),
            column(12, verbatimTextOutput("x4"))
        )
    )
)

page_three <- tabPanel(
    "Summary Charts",
    titlePanel("Gender and Party Differences in the House by State"),
    sidebarLayout(
        sidebarPanel(
            selectInput("summ_state", "State:",
                        choices = sort(unique(congress_df$state)),
                        selected = "WA")
        ),
        mainPanel(
            plotOutput("genderPlot"),
            plotOutput("partyPlot")
        )
    )
)


ui <- navbarPage(
    "a7: ProPublica Congress API",
    page_one,
    page_two,
    page_three
)

# Server functions
server <- function(input, output) {
    output$stateRepsTable <- renderDataTable(
        get_reps_by_cham_state(input$chamber, input$state),
        selection = "single"
    )
    
    output$x4 = renderPrint({
        s = input$stateRepsTable_rows_selected
        if (length(s)) {
            get_rep_by_name(s)
        }
    })
    
    output$genderPlot <- renderPlot({
        gender_plot(input$summ_state)
    })
    
    output$partyPlot <- renderPlot({
        party_plot(input$summ_state)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
