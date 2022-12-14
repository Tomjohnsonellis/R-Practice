# Exercise 1: building a Shiny user interface

# Load the `shiny` package (install it in the R terminal if you haven't already)
library(shiny)

# Define a new `ui` variable. This variable should be assigned a `fluidPage()`
# layout. The `fluidPage()` layout should be passed the following:
ui <- fluidPage(
  h1("My First Shiny Website"),
  p(strong("Shiny is very epic,"), "I much prefer programatically created websites to things like wordpress!"),
  img(src = "https://bestanimations.com/Sci-Fi/Aliens/alien-robot-dancing-1.gif"),
  p("WOW A SLIDER THAT'S", em("POG")),
  sliderInput(
    inputId = "my_slider",
    label = "A slider",
    min = 10,
    max = 100,
    value = 50
    )
  
)
  

# A first-level header (`h1()`) with the content "First Shiny Website"
# A paragraph (`p()`) with content saying how excited you are about Shiny.
# The paragraph should include some `strong()` content.
# An image (`img()`) with no content but the `src` attribute of the url:
# https://media2.giphy.com/media/l3q2Ip7FrmPE33EiI/giphy.gif
# A second paragraph describing how excited you are about sliders.
# The paragraph should include some emphasized (`em()`) content.
# A slider with a key `my_slider`, an appropriate label, a min value of 10,
# A max value of 100, and a default value of 50


# (Your `fluidLayout()` should end here)


# This defines a server that doesn't do anything yet, but is needed to run the app.
server <- function(input, output) {
  # Will be next!
}

# Create a new `shinyApp()` using the above ui and server
shinyApp(ui = ui, server = server)
