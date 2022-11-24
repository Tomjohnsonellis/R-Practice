# Exercise 1: Creating a grouped bar chart of cancer rates in King County, WA
# (using plotly)

# Load necessary packages (`dplyr`, `ggplot2`, and `plotly`)
# install.packages("plotly")
my_packages <- c("dplyr", "ggplot2", "plotly")

## I found a way to load all the packages at once, not THAT useful, but still neat
lapply(my_packages, require, character.only = TRUE)

# Set your working directory using the RStudio menu:
# Session > Set Working Directory > To Source File Location
setwd("~/GitHub/R-Practice/Exercises/chapter-17")

# Load the `"data/IHME_WASHINGTON_MORTALITY_RATES_1980_2014.csv` file
# into a variable `mortality_rates`
# Make sure strings are *not* read in as factors
## The book likes to remind me of this, the function now does this by default.
mortality_rates <- read.csv("data/IHME_WASHINGTON_MORTALITY_RATES_1980_2014.csv")


# This is actually a very large and rich dataset, but we will only focus on
# a small subset of it. Create a new data frame `plot_data` by filtering the
# `mortality_rates` data to the following:
# - The `location_name` is "King County"
# - The `sex` is *not* "Both"
# - The `cause_name` is "Neoplasms"
# - The `year_id` is greater than 2004
# - Only keep the columns `sex`, `year_id`, and `mortality_rate`

plot_data <- mortality_rates %>%
  filter(location_name == "King County") %>%
  filter(sex != "Both") %>%
  filter(cause_name == "Neoplasms") %>%
  filter(year_id > 2004) %>%
  select(sex, year_id, mortality_rate)

## From 135,800 observations to just 20!

# Using ggplot2 (recall chapter 16), make a grouped ("dodge") bar chart of
# mortality rates each year, with different bars for each sex.
# Store this plot in a variable `mort_plot`
mort_plot <- plot_data %>%
  ggplot() +
  geom_col(
    mapping = 
      aes(
        x = year_id,
        y = mortality_rate,
        fill = sex
      ),
    position = "dodge"
  )

# To make this plot interactive, pass `mort_plot` to the `ggplotly()` function
# (which is part of the `plotly` package). This will make your plot interactive!
mort_plot %>%
  ggplotly()
## Neat! Currently just a "highlight the area for more info" but still pretty!

# As an alternative to making a ggplot chart interactive, we can build the same
# plot using the plotly API directly

# Using the `plot_ly()` function from the `plotly` package, pass in `plot_data`
# as the data, and specify `year_id` as the x variable, mortality_rate as
# the y variable, and `sex` as the color variable. 
# (make sure to specify these as *formulas*)
# Also set the plot type to "bar". Store the result in a variable.
my_plotly_plot <- plot_data %>%
  plot_ly(x = ~year_id, y = ~mortality_rate, color = ~sex, type = "bar")
## Plotly uses the ~ (tilde) symbol to specify a formula.


# You should see that the cancer mortaility rates for female and males 
# each year are plotted next to each other.
# Now that we have the foundation down, we can make our plot more presentable
# by adding a layout to the plot. Add a title for the overall plot, and
# a title for each axes.
my_plotly_plot %>%
  layout(
    title = "Deaths by Neoplasms",
    xaxis = list(title="Year"), ## Personally I prefer ggplot's syntax
    yaxis = list(title="Mortality Rate")
  )

## plotly is fairly similar to ggplot, but with the bonus of being interactive
## At a guess, use ggplot for something you print out or need to put into a pdf,
## and use plotly for webapps.
