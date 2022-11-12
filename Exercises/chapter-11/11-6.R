# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
colnames(flights)
colnames(airports)

## I finally had to look at the tidyverse documentation!
## The "by = " syntax is a little different to R's merge
## Turns out merging before necessary can cause problems, this was my first attempt
# arrival_delays <- flights %>%
#   select(dest, arr_delay) %>%
#   left_join(airports, by = c("dest" = "faa")) %>%
#   arrange(desc(arr_delay)) %>%
#   group_by(dest)


arrival_delays <- flights %>%
  group_by(dest) %>%
  summarise(average_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airports, by = c("dest" = "faa")) %>%
  arrange(desc(average_delay))

## Biggest average delay  
arrival_delays[1,]

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
?flights
colnames(flights)
colnames(airlines)
airline_delays <- flights %>%
  group_by(carrier) %>%
  summarise(average_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airlines, by = "carrier") %>%
  arrange(desc(average_delay))

# Most delayed (on average) airline
airline_delays[1,]
