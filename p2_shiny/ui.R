#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

page_one <- tabPanel(
    "Introduction",
    titlePanel("Mental Health in the Technology Workplace"),
    
)

page_two <- tabPanel(
    "Background",
    titlePanel("Background Information and our Research Questions")

)

page_three <- tabPanel(
    "Viz. 1",
    titlePanel("Our First Visualization"),
    sidebarLayout(
        sidebarPanel(
            h3("Viz. Controls")
        ),
        mainPanel(
            h3("Viz.")
        )
    ),
    p("Findings")
)

page_four <- tabPanel(
    "Viz. 2",
    titlePanel("Our Second Visualization"),
    sidebarLayout(
        sidebarPanel(
            h3("Viz. Controls")
        ),
        mainPanel(
            h3("Viz.")
        )
    ),
    p("Findings")
)

page_five <- tabPanel(
    "Conclusion",
    titlePanel("What We Found"),
    
)

page_six <- tabPanel(
    "Technical Report",
    titlePanel("Link To Report"),
    
)

page_seven <- tabPanel(
    "About Us",
    titlePanel("Who We Are"),
    
)

shinyUI(navbarPage(
    "P2: Midpoint Project Deliverable",
    page_one,
    page_two,
    page_three,
    page_four,
    page_five,
    page_six,
    page_seven
))