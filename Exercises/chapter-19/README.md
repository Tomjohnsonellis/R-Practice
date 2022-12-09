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


## Exercise 4: complex Shiny UI layouts
Using more shiny objects to construct website layouts, all done via code!
It's considered good practice to split the shiny app into 2 files, one for the ui and one for the server, as debugging shiny apps can be a hassle.
```
# app.R
source("my_app_ui.R") # Creates the UI in a variable called "my_ui"
source("my_app_server.R") # Creates the server in a variable called "my_server"
shinyApp(ui = my_ui, server = my_server)
```

## Exercise 5: An interactive scatter plot
Using dropdowns to create a scatter plot of the "MPG" dataset, you can also change the colour.

## Exercise 6: Interactive mapping
The server should be responsible for any "backend" work like creating the dataset and processing it, the UI should be responsible for just displaying things.

## Exercise 7: interactive applications
The final shiny exercise, we create an app with 2 pages, with a different interactive graph on each page, looks clean and does indeed function!