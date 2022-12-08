# Chapter 19: Building Interactive Web Applications with Shiny
For this chapter, each exercise creates a simple web page!
Each webpage is stored in the relevant exercise folder as they each need to be called "app.R".

## Exercise 1: Building a Shiny user interface
Starting off nice and simple, some text and a slider that doesn't actually do anything!
```
ui <- fluidPage(
sliderInput(inputId = "slider", label = "I am a slider")
)
```

## Exercise 2: A basic Shiny app
This time we have some functionality, multiplying 2 inputs!
```
ui <- fluidPage(
numericInput(InputID = "qty_one"),
numericInput(InputID = "qty_two"),
textOutput("result")
)

server <- function(input, output){
output$result <- renderText(
    {return(paste0(input$qty_one * input$qty_two))}
  )
}

```

## Exercise 3: interactive Shiny apps
We connect a slider to a graph, allowing us to change the graph's input data!
This used the diamonds dataset, so the slider controls the range of prices used.
```
ui <- fluidPage(

  sliderInput(
    inputId = "prices",
    label = "Price (in dollars)",
    min = price_range[1],
    max = price_range[2],
    value = price_range
  )

  plotOutput("plot")
)
#####

server <- function(input, output){
output$plot <- renderPlot(
    {
      plot_data <- dataset %>%
        filter(price > input$price_choice[1], # I was expecting more like
               price < input$price_choice[2]) # price_choice$min or similar
      
      p <- ggplot(data = plot_data, ...ggplotcode...)
      }
  }
        
        
```