# Exercise 1: working with data frames (review)

# Install devtools package: allows installations from GitHub
install.packages("devtools")

# Install "fueleconomy" dataset from GitHub
devtools::install_github("hadley/fueleconomy")

# Use the `libary()` function to load the "fueleconomy" package
library(fueleconomy)

# You should now have access to the `vehicles` data frame
# You can use `View()` to inspect it
View(vehicles)

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
brands <- vehicles$make

# Use the `unique()` function to determine how many different car manufacturers
# are represented by the data set
length(unique(brands))

# Filter the data set for vehicles manufactured in 1997
vehicles$model[vehicles$year == 1997]

# Arrange the 1997 cars by highway (`hwy`) gas milage
# Hint: use the `order()` function to get a vector of indices in order by value
# See also:
# https://www.r-bloggers.com/r-sorting-a-data-frame-by-the-contents-of-a-column/
df <- data.frame(vehicles)
my_subset <- vehicles[vehicles$year == 1997,]
my_subset <- my_subset[order(my_subset$hwy, decreasing = TRUE),]

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
average <- (my_subset$hwy + my_subset$cty) / 2
my_subset <- cbind(my_subset, average)

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
colnames(vehicles)
unique(vehicles$drive)
city_cars <- vehicles[vehicles$drive == "2-Wheel Drive" & vehicles$cty > 20,]

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
## There are 2 cars that get equally bad milage
city_cars$id[city_cars$hwy == min(city_cars$hwy)]

# Write a function that takes a `year_choice` and a `make_choice` as parameters, 
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
best_brand_mpg <- function(year_choice, make_choice){
  # Work only with the data we care about
  my_subset <- vehicles[vehicles$year == year_choice & vehicles$make == make_choice,]
  fuel_effecient_car <- my_subset$model[my_subset$hwy == max(my_subset$hwy)]
  fuel_effecient_car
}

unique(brands)
best_brand_mpg(2000, "Suzuki")
# What was the most efficient Honda model of 1995?
best_brand_mpg(1995, "Honda")
