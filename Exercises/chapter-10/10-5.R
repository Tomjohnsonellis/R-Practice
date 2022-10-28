# Exercise 5: large data sets: Baby Name Popularity Over Time

# Read in the female baby names data file found in the `data` folder into a 
# variable called `names`. Remember to NOT treat the strings as factors!
setwd("~/GitHub/R-Practice/Exercises/chapter-10")
names <- read.csv("data/female_names.csv", stringsAsFactors = FALSE)

# Create a data frame `names_2013` that contains only the rows for the year 2013
dim(names)
colnames(names)
names_2013 <- names[names$year == 2013,]
dim(names_2013)

# What was the most popular female name in 2013?
head(names_2013)
names_2013$name[names_2013$prop == max(names_2013$prop)]

# Write a function `most_popular_in_year` that takes in a year as a value and 
# returns the most popular name in that year
most_popular_in_year <- function(some_year){
  subset <- names[names$year == some_year,]
  result <- subset$name[subset$prop == max(subset$prop)]
  result
}
most_popular_in_year(2010)

# What was the most popular female name in 1994?
most_popular_in_year(1994)

# Write a function `number_in_million` that takes in a name and a year, and 
# returns statistically how many babies out of 1 million born that year have 
# that name. 
# Hint: get the popularity percentage, and take that percentage out of 1 million.
head(names)
number_in_million <- function(name, year){
  # Rounding to 0 as 0.6 people having a name doesn't make sense
  # "What is the proportion data for people with this name in this year"
  round(1000000 * names$prop[names$name == name & names$year == year], 0)  
}
number_in_million("Mary", 2002)

# How many babies out of 1 million had the name 'Laura' in 1995?
number_in_million("Laura", 1995)

# How many babies out of 1 million had your name in the year you were born?
number_in_million("Thomas", 1995)

## Consider: what does this tell you about how easy it is to identify you with 
## just your name and birth year?
#### I looked up the US population for 1995 (~265 Million)
265 * number_in_million("Thomas", 1995)
#### 4240 is a a lot less than I thought it would be, if someone was so inclined
#### they could quite easily trawl through 4000 mugshots in a day. 