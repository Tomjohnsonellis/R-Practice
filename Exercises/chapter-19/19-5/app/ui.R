# UI for scatterplot
library(shiny)
library(ggplot2)

# Get a vector of column names (from `mpg`) to use as select inputs
select_inputs <- colnames(mpg)
# Create a variable `x_input` that stores a `selectInput()` for your
# variable to appear on the x axis of your chart.
# Use the vector of column names as possible values, and make sure
# to assign an inputId, label, and selected value
x_input <- selectInput(
  inputId = "x_input",
  label = "X axis?",
  choices = select_inputs,
  selected = select_inputs[1]
)

# Using a similar approach, create a variable `y_input` that stores a
# `selectInput()` for your variable to appear on the y axis of your chart.
# Add a `selectInput` for the `y` variable
y_input <- selectInput(
  inputId = "y_input",
  label = "Y axis?",
  choices = select_inputs,
  selected = select_inputs[2]
)

# Create a variable `color_input` as a `selectInput()` that allows users to
# select a color from a list of choices
colour_input <- selectInput(
  inputId = "colour_input",
  label = "Colour?",
  # I had to look at the solution for this, cases can be tricky!
  choices = list("Red" = "red", "Blue" = "blue", "Green" = "green")
)

# Create a variable `size_input` as a `sliderInput()` that allows users to
# select a point size to use in your `geom_point()`
size_input <- sliderInput(
  inputId = "slider_input",
  label = "Size of points?",
  min = 1,
  max = 10,
  value = 3
)

# Create a variable `ui` that is a `fluidPage()` ui element. 
# It should contain:
ui <- fluidPage(
  titlePanel("An interactive graph of the inbuild mpg dataset"),
  x_input,
  y_input,
  colour_input,
  size_input,
  plotOutput("scatter")
)
# A page header with a descriptive title


# Your x input


# Your y input


# Your color input


# Your size input


# Plot the output with the name "scatter" (defined in `app_server.R`)
