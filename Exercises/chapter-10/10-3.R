# Exercise 3: working with built-in data sets

# Load R's "USPersonalExpenditure" dataset using the `data()` function
# This will produce a data frame called `USPersonalExpenditure`
data("USPersonalExpenditure")

# The variable `USPersonalExpenditure` is now accessible to you. Unfortunately,
# it's not a data frame (it's actually what is called a matrix)
# Test this using the `is.data.frame()` function
is.data.frame(USPersonalExpenditure)

# Luckily, you can pass the USPersonalExpenditure variable as an argument to the
# `data.frame()` function to convert it a data frame. Do this, storing the
# result in a new variable
df <- data.frame(USPersonalExpenditure)

# What are the column names of your dataframe?
colnames(df)

## Consider: why are they so strange? Think about whether you could use a number 
## like 1940 with dollar notation!
### Tom here: That makes sense, variables in R must start with a letter
### and X is a very commonly used placeholder letter

# What are the row names of your dataframe?
rownames(df)

# Add a column "category" to your data frame that contains the rownames
category <- rownames(df)
df <- cbind(df, category)

# How much money was spent on personal care in 1940?
df["Personal Care","X1940"]

# How much money was spent on Food and Tobacco in 1960?
df["Food and Tobacco","X1960"]

# What was the highest expenditure category in 1960?
## Syntax: df$column[condition to meet]
df$category[df$X1960 == max(df$X1960)]

# Define a function `lowest_category` that takes in a year as a parameter, and
# returns the lowest spending category of that year
lowest_category <- function(year){
  column <- paste("X", year, sep = "")
  ## Tom here: The $ notation doesn't seem to work for strings
  #lowest <- df$category[df$column == min(df$column)]
  lowest <- df$category[df[,column] == min(df[,column])]
  lowest
}

lowest_category(1940)

# Using your function, determine the lowest spending category of each year
# Hint: use the `sapply()` function to apply your function to a vector of years
colnames(df)
## As the function adds an X to a year name, I can't just pass the column names
# sapply(colnames(df),lowest_category)
## But I can create a sequence of years to pass
sapply(seq(1940,1960,5), lowest_category)
