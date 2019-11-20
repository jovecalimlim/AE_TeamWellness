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
    p("Placeholder Intro Paragraph")
)

page_two <- tabPanel(
    "Background",
    titlePanel("Background Information and our Research Questions"),
    p("Placeholder Background Info Paragraph")
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
    p("Placeholder Research Findings Paragraph")
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
    p("Placeholder Research Findings Paragraph")
)

page_five <- tabPanel(
    "Conclusion",
    titlePanel("What We Found"),
    p("Placeholder Conclusion Paragraph")
)

page_six <- tabPanel(
    "Technical Info",
    titlePanel("Our Technical Report"),
    p("Placeholder Tech Report Link")
)

page_seven <- tabPanel(
    "About Us",
    titlePanel("Who We Are"),
    p("Placeholder About Us Paragraph")
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
