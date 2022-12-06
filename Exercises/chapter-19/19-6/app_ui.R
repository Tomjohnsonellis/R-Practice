# Libraries
library(plotly)
library(shiny)

# ui.R
ui <- fluidPage(
  mainPanel(
    # Add a selectInput that allows you to select a variable to map
    selectInput(inputId = "map_variable",
                label = "Select a variable to map", 
                choices = list("Pop" = "population",
                               "Votes" = "votes",
                               "Votes / Pop" = "ratio"
                               )
                ),
    # Use `plotlyOutput()` to show your map
    plotlyOutput("votemap")
  )
)
