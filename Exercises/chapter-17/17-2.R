# Exercise 2: Creating a grouped bar chart of cancer rates in King County, WA
# (using rbokeh)

# Load necessary packages (`dplyr`, `ggplot2`, and `rbokeh`)
#install.packages("robkeh")
# remotes::install_github("bokeh/rbokeh")
library(dplyr)
library(ggplot2)
library(rbokeh)

# Set your working directory using the RStudio menu:
# Session > Set Working Directory > To Source File Location
setwd("~/GitHub/R-Practice/Exercises/chapter-17")
# Load the `"data/IHME_WASHINGTON_MORTALITY_RATES_1980_2014.csv` file
# into a variable `mortality_rates`
# Make sure strings are *not* read in as factors
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
## Or I can do it with one filter statement
plot_data <- mortality_rates %>%
  filter(
    location_name == "King County",
    sex != "Both",
    cause_name == "Neoplasms",
    year_id > 2004,
  ) %>%
  select(sex, year_id, mortality_rate)


# Creating a plot with rbokeh requires a few steps:

# Initialize your chart using the `figure()` function, specifying:
# - The `data`  to plot (e.g., `plot_data`), and
# - The `title` (e.g., "Neoplasms Mortality Rate in King County")
# Store this in a variable `p`

p <- figure(data = plot_data, title = "Neoplasms Mortality Rate")


# Then, add a layer of bars (via a pipe %>%) specifying your data encodings. 
# You will use the `ly_bar()` function to do this, which (oddly) requires that 
# the `x` variable is specified as a string (i.e., as.character(year_id)). Set:
# - The `x` variable as the `year_id` (as a *character*)
# - The `y` variable as the `mortality_rate`
# - The `color` varaible as the `sex`
# - The `position` as "dodge" (as opposed to stacked)
p <- p %>%
  ly_bar(x = as.character(year_id), y = mortality_rate, color = sex, position = "dodge")

p
# Finally, you can add better axis labels (again, via a pipe %>%) by passing 
# your plot `p` to the `x_axis()` and `y_axis()` functions.
p %>%
  x_axis(label = "Year") %>%
  y_axis(label = "Mortality Rate")

