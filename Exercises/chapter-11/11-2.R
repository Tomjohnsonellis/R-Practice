# Exercise 2: working with `dplyr`
# Note that this exercise repeats the analysis from Exercise 1, but should be 
# performed using `dplyr` (do not directly access or manipulate the data frames)

# Install and load the "fueleconomy" package
#install.packages("devtools")
#devtools::install_github("hadley/fueleconomy")
library(fueleconomy)

# Install and load the "dplyr" library
install.packages("dplyr")
library("dplyr")
# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
car_makes <- select(vehicles, make)

# Use the `distinct()` function to determine how many different car manufacturers
# are represented by the data set
distinct(car_makes)

# Filter the data set for vehicles manufactured in 1997
man_1997 <- filter(vehicles, year == 1997)

# Arrange the 1997 cars by highway (`hwy`) gas mileage
## More mileage is better so I'll sort by best to worst
arrange(man_1997, desc(hwy))

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
mutate(vehicles, average = (cty+hwy)/2)

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
filter(vehicles, drive == "2-Wheel Drive", cty > 20)

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
filtered_cars <- filter(vehicles, drive == "2-Wheel Drive", cty > 20)
filtered_cars <- filter(filtered_cars, hwy == min(hwy))
## There were 2 cars last time we did this, same again here
select(filtered_cars, id)

# Write a function that takes a `year_choice` and a `make_choice` as parameters,
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
best_hwy_in_year <- function(year_choice, make_choice){
  results <- filter(vehicles, year == year_choice, make == make_choice)
  best_mpg <- filter(results, hwy == max(hwy))
  select(best_mpg, model)
}

# What was the most efficient Honda model of 1995?
best_hwy_in_year(1995, "Honda")
## We got the "Civic HB VX", same as last time so we've done everything right!
## (Or done it identically wrong with both base R and dplyr)