# Exercise 6: interactive mapping

# Load libraries so they are available
library("shiny")

# Use source() to execute the `app_ui.R` and `app_server.R` files. These will
# define the UI value and server function respectively.
setwd("~/GitHub/R-Practice/Exercises/chapter-19/19-6")
source("app_ui.R")
source("app_server.R")
# You will need to fill in the `app_ui.R` file to create the layout.
# Run the app through this file.

# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui, server)
