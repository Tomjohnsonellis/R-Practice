# Chapter 17
## Exercise 1: Creating a grouped bar chart of cancer rates in King County, WA
## (using plotly)
The syntax for plotly is a little different, but so far it seems to be a useful package for quickly making interactive graphs!
```
some_ggplot_object %>%
ggplotly()
```

## Exercise 2: Rbokeh
A run through of the previous exercise but this time using a different plotting package
```
a_plot <- figure(data_to_plot, a_title)
a_plot %>% ly_bar(x,y)
```

## Exercise 3: Mapping U.S. city populations
## (using leaflet)