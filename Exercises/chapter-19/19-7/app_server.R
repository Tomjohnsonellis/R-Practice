# server.R
library(dplyr)

# Read in data
source('./scripts/build_map.R')
source('./scripts/build_scatter.R')
df <- read.csv('./data/electoral_college.csv', stringsAsFactors = FALSE)
state_codes <- read.csv('./data/state_codes.csv', stringsAsFactors = FALSE)

# Join together state.codes and df
joined_data <- left_join(df, state_codes, by="state")

# Compute the electoral votes per 100K people in each state
joined_data <- joined_data %>% mutate(ratio = votes/population * 100000)

# Define your shiny server in which you...


server <- function(input, output){
  # Render a plotly object that returns your map
  output$map <- renderPlotly(build_map(joined_data, input$map_var))
  
  # Render a plotly object that returns your scatter plot
  output$scatter <- renderPlotly(build_scatter(joined_data, input$search))  
}



####### From what I can tell, the solution has the same issue I am currently having.


