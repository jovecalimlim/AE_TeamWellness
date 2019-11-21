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
source("EugeneWorkPlace.R")
source("SAM_Dataset.R")

# Pages 1-7 instantiated and structured for use
page_one <- tabPanel(
    "Introduction",
    titlePanel("Mental Health in the Technology Workplace"),
    p("Placeholder First Intro Paragraph"),
    p("Placeholder Second Intro Paragraph")
)

page_two <- tabPanel(
    "Background",
    titlePanel("Background Information and our Research Questions"),
    p("Placeholder Background Info Paragraph"),
    p("Placeholder Research Questions Paragraph")
)

page_three <- tabPanel(
    "Interactive Map",
    titlePanel("Prevalence of Mental Illness Throughout the United States"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("radio",
                         label = h3("Select Year"),
                         choices = list("2016" = 1,
                                        "2017" = 2,
                                        "2018" = 3),
                         selected = 1),
            actionButton("update", "Update Map"),
            hr()
        ),
        mainPanel(
            interactive_map
        )
    ),
    p("Placeholder Research Findings Paragraph")
)

page_four <- tabPanel(
    "Bar Charts",
    titlePanel("Survey Question Charts"),
    sidebarLayout(
        sidebarPanel(
            selectInput("select", 
                        label = h3("Select Survey Question"),
                        choices = list("Would you bring up a physical health issue 
                                       with a potential employer in an interview?" = 1,
                                       "Would you bring up a mental health issue 
                                       with a potential employer in an interview?" = 2,
                                       "Would you be willing to discuss a mental 
                                       health issue with your direct supervisor(s)?" = 3),
                        selected = 1),
            actionButton("update", "Update Plot"),
            hr()
        ),
        mainPanel(
            plotOutput("plot")
        )
    ),
    p("Placeholder Research Findings Paragraph")
)

page_five <- tabPanel(
    "Conclusion",
    titlePanel("What We Found"),
    p("Placeholder First Conclusion Paragraph"),
    p("Placeholder Second Conclusion Paragraph")
)

page_six <- tabPanel(
    "Technical Info",
    titlePanel("Our Technical Report"),
    p("Placeholder Tech Report Summary Paragraph"),
    p("Placeholder Tech Report Link")

)

page_seven <- tabPanel(
    "About Us",
    titlePanel("Who We Are"),
    p("Placeholder About Us Paragraph")
)

# UI pages set in navbarPage style
ui <- navbarPage(
    "P2: Midpoint Project Deliverable",
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
    output$plot <- renderPlot({
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
