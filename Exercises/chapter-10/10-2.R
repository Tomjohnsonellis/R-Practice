# Exercise 2: working with data frames

# Create a vector of 100 employees ("Employee 1", "Employee 2", ... "Employee 100")
# Hint: use the `paste()` function and vector recycling to add a number to the word
# "Employee"
employees <- c(paste("Employee",1:100))

# Create a vector of 100 random salaries for the year 2017
# Use the `runif()` function to pick random numbers between 40000 and 50000
## Tom here: I kept reading this as "Run If", but it's 
## "R Unif" as in R's Uniform Distribution function
current_salaries <- runif(100, min=40000, max=50000)

# Create a vector of 100 annual salary adjustments between -5000 and 10000.
# (A negative number represents a salary decrease due to corporate greed)
# Again use the `runif()` function to pick 100 random numbers in that range.
adjustments <- runif(100, min=-5000, max=10000)

# Create a data frame `salaries` by combining the 3 vectors you just made
# Remember to set `stringsAsFactors=FALSE`!
salaries <- data.frame(current_salaries,adjustments,row.names = employees)

# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).
new_salaries = current_salaries + adjustments
salaries <- cbind(salaries, new_salaries)

# Add a column to the `salaries` data frame that has a value of `TRUE` if the 
# person got a raise (their salary went up)
salaries <- cbind(salaries, payrise = (new_salaries > current_salaries))


### Retrieve values from your data frame to answer the following questions
### Note that you should get the value as specific as possible (e.g., a single
### cell rather than the whole row!)

# What was the 2018 salary of Employee 57
salaries["Employee 57","new_salaries"]

# How many employees got a raise?
sum(salaries$payrise)

# What was the dollar value of the highest raise?
max(salaries$adjustments)

# What was the "name" of the employee who received the highest raise?
## Tom here: This syntax was a little tricky first time,
## rownames(dataframe)[condition]
rownames(salaries)[which.max(salaries$adjustments)]

# What was the largest decrease in salaries between the two years?
min(salaries$adjustments)

# What was the name of the employee who recieved largest decrease in salary?
rownames(salaries)[which.min(salaries$adjustments)]

# What was the average salary change?
mean(salaries$adjustments)

# For people who did not get a raise, how much money did they lose on average?
## The syntax here is: function(dataframe$coloumn[condition to meet])
mean(salaries$adjustments[salaries$payrise == FALSE])

## Consider: do the above averages match what you expected them to be based on 
## how you generated the salaries?
#### Tom here: The average pay adjustment being ~2500 makes sense as
#### we generated a uniform distribution between -5000 and +10000,
#### It's right in the middle.
#### The negative values also make sense, a little further off the middle but
#### about the midpoint of -5000 and 0

# Write a .csv file of your salary data to your working directory
getwd()
setwd("~/GitHub/R-Practice/Exercises/chapter-10")
write.csv(salaries, "salaries.csv")
