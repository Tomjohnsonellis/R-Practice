library(shiny)
library(ggplot2)

basic_sidebar_panel <- sidebarPanel("I am a sidebar panel")
slider_sidebar_panel <- sidebarPanel("I am also a sidebar panel, with a sider!",
                                     sliderInput(inputId = "sidebar_slider",
                                                 label = "I am an input slider",
                                                 min = 0,
                                                 max = 100,
                                                 value = 50)
                                     )
dropdown_sidebar_panel <-  sidebarPanel("I am another sidebar panel, please choose a colour.",
                                        selectInput(inputId = "colour_choice",
                                                    label = "Colour",
                                                    choices = list("red","blue","green"),
                                                    selected = "red"
                                        )) 


page_one <- tabPanel(
  titlePanel("Page 1"),
    sidebarLayout(
    basic_sidebar_panel,
    mainPanel = mainPanel("I am a main panel, I contain content.")
  )
)

page_two <- tabPanel(
  titlePanel("Page 2"),
  sidebarLayout(
    slider_sidebar_panel,
    mainPanel = mainPanel("I am another main panel.")
  )
)

page_three <- tabPanel(
  titlePanel("Page 3"),
  sidebarLayout(
    dropdown_sidebar_panel,
    mainPanel = mainPanel(plotOutput("plot"))
  )
)


my_ui <- fluidPage(
  navbarPage("I am a navbar", page_one, page_two, page_three) 
  )


