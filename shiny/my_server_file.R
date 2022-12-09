library(dplyr)
library(shiny)

normal_data <- rnorm(100, mean = 100, sd = 15) # Guess the reference!
normal_data <- data.frame(normal_data)
normal_data$normal_data <- as.integer(normal_data$normal_data)
bins_to_use <- range(normal_data)[2] - range(normal_data)[1]



# my_plot <- ggplot(data = normal_data) +
#   geom_histogram(mapping = aes(x = normal_data),
#                  bins = bins_to_use,
#                  fill = "red")



my_server <- function(input, output){
  # Code here
  output$plot <- renderPlot({
    ggplot(data = normal_data) +
      geom_histogram(mapping = aes(x = normal_data),
                     bins = bins_to_use,
                     fill = input$colour_choice)
    
  })
}