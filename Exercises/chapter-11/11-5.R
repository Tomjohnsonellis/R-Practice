# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
## Reading the actual task carefully helps a lot, my first attempt made a new column
colnames(flights)
group_by(flights, month) %>%
  mutate("dep_delay_by_month" == mean(dep_delay))
colnames(flights)
# This didn't actually save it! Always remember to save your work.

library(nycflights13)
colnames(flights)
dep_delay_by_month <- flights %>%
  group_by(month) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))
dep_delay_by_month

# Which month had the greatest average departure delay?
filter(dep_delay_by_month, delay == max(delay))
## Month 7, also known to humans as "July"

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
plot(dep_delay_by_month)
## Not the prettiest graph, but usable

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows

## Group the data by destination, make a summary with the average arrival delay,
## then sort the results!
delayed <- group_by(flights, dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(-delay)

# You can look up these airports in the `airports` data frame!
colnames(airports)
?airports
colnames(delayed)
delayed
filter(airports, faa == delayed$dest[1])

## I wanted to make a column that was the full names but had difficulties
## I'd have to match the dest codes to the airports dataframe, which is
## currently beyond me.
### Update: the merge function is a thing! I just had to name the airport codes
### column the same thing so R could merge the dataframes.
colnames(airports)

delayed
colnames(delayed)
codes_and_names <- select(airports, faa, name)
colnames(codes_and_names) <- c("dest", "name")
codes_and_names
delayed <- merge(delayed, codes_and_names, by = "dest")
dim(delayed)
head(delayed)

# dplyr has a similar function, the left_join()
delayed <- group_by(flights, dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(-delay)

left_join(delayed, codes_and_names, by = "dest")


# Which city was flown to with the highest average speed?
speedy_city <- flights %>%
  mutate(speed = distance / air_time * 60) %>%
  group_by(dest) %>%
  summarise(avg_speed = mean(speed, na.rm = TRUE)) %>%
  filter(avg_speed == max(avg_speed, na.rm = TRUE))
speedy_city
