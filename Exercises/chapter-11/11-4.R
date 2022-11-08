# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
?flights
ncol(flights)
nrow(flights)
dim(flights)
colnames(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
colnames(flights)
## A flight that departs on time and arrives 10 minutes early (a negative delay) gains time
flights <- mutate(flights, extra_time = arr_delay - dep_delay)


# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, desc(extra_time))

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- mutate(flights, extra_time = arr_delay - dep_delay) %>% 
  arrange(desc(extra_time))

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$extra_time)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights$extra_time, na.rm = TRUE)
## An average of -5.7, on average flights lose 5-6mins of time in the air

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
seatac_flights <- select(flights, origin, dest, extra_time) %>% filter(dest == "SEA")

# On average, did flights to SeaTac gain or lose time?
mean(seatac_flights$extra_time, na.rm = TRUE)
## On average, they lose about 11 mins

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
## I found this pretty tricky, this was my first attempt
colnames(flights)
filter(flights, origin == "JFK") %>%
  filter(dest == "SEA") %>%
  select(air_time) %>%
  min(rm.na = TRUE)
## But this way of doing it limits me to one final function, a better way is:
filter(flights, origin == "JFK") %>%
  filter(dest == "SEA") %>%
  summarise(
    avg_air = mean(air_time, na.rm = TRUE),
    min_air = min(air_time, na.rm = TRUE),
    max_air = max(air_time, na.rm = TRUE)
  )
