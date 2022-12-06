### Exercise 5 ###

library(shiny)
library(ggplot2)
# Create a shiny server that creates a scatterplot. 
server <- function(input, output){
  output$scatter <- renderPlot({
    title <- paste0("MPG Dataset of ", input$x_input, "vs.", input$x_input)
    p <- ggplot(data = mpg) +
      geom_point(mapping = aes_string(input$x_input, input$y_input),
                 size = input$slider_input,
                 color = input$colour_input)
    
    p
  })
    
}
# It should use an `input` with features: `x_var`, `y_var`, `color`, and `size`
# Save the result of `renderPlot` to output$scatter