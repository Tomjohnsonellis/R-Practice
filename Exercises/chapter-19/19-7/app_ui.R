# ui.R
library(shiny)
library(plotly)

# Define a variable `map_sidebar_content` that is a `sidebarPanel()` for your
# first (map) page that contains:
# An input to select variable to map
map_sidebar_content <- sidebarPanel(
  selectInput(inputId = "map_var",
              label = "Variable to map",
              choices = list(
                "Population" = "population",
                "Electoral Votes" = "votes",
                "Votes / Population" = "ratio"
                )
  )
)
# Define a variable `map_main_content` that is a `mainPanel()` for your
# first (map) page that contains the `plotlyOutput()` of your map
map_main_content <- mainPanel(plotlyOutput("map"))
# Create a variable `map_panel` that stores a `tabPanel()` for your first page
# It should include the following:
map_panel <- tabPanel(titlePanel("A Map"),
                      sidebarLayout(
                        map_sidebar_content,
                        map_main_content
                      ))
# A `sidebarLayout()` that contains...
# Your `map_sidebar_content`
# Your `map_main_content`


# Define a variable `scatter_sidebar_content` that is a `sidebarPanel()` for 
# your second (scatter) page that contains:
# - a `textInput()` widget for searching for a state in your scatter plot

## I tried to go for a dropdown, just for fun but the given script was not a fan.
# states <- read.csv("data/state_codes.csv")
# states$code
# 
# scatter_sidebar_content <- sidebarPanel(
#   selectInput(inputId = "state",
#             label = "Select a state",
#             choices = states$code)
# )

scatter_sidebar_content <- sidebarPanel(
  textInput("search", label = "Find a State", value = "")
)

# Define a variable `scatter_main_content` that is a `mainPanel()` for your
# second (scatter) page that contains the `plotlyOutput()` of your scatter
scatter_main_content <- mainPanel(
  plotlyOutput("scatter")
)

# Create a variable `scatter_panel` that stores a `tabPanel()` for your 2nd page
# It should include the following:
scatter_panel <- tabPanel(
  titlePanel("Scatter, Senbonzakura"),
  sidebarLayout(
    scatter_sidebar_content,
    scatter_main_content
  )
)
# Add a titlePanel to your tab
# Create a sidebar layout for this tab (page)
# Display your `scatter_sidebar_content`
# Display your `scatter_main_content`

# Define a variable `ui` storing a `navbarPage()` element containing
# your two pages defined above
ui <- navbarPage("2 Panels :-) ", map_panel, scatter_panel)


####### From what I can tell, the solution has the same issue I am currently having.
