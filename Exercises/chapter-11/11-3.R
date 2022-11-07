# Exercise 3: using the pipe operator

# Install (if needed) and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library("fueleconomy")

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes--use temporary variables!)
acura_cars <- filter(vehicles, make == "Acura")
best_mpg <- filter(acura_cars, hwy == max(hwy))
best_model <- select(best_mpg, model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
select(filter(filter(vehicles, make == "Acura"), hwy == max(hwy)), model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr and the pipe operator)
## When piping, I believe it uses the result as the first variable in the next function
filter(vehicles, make == "Acura") %>% filter(hwy == max(hwy)) %>% select(model)


### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times
temp_method <- function(){
  acura_cars <- filter(vehicles, make == "Acura")
  best_mpg <- filter(acura_cars, hwy == max(hwy))
  best_model <- select(best_mpg, model)
  best_model
  }

nest_method <- function(){
  select(filter(filter(vehicles, make == "Acura"), hwy == max(hwy)), model)
}

pipe_method <- function(){
  filter(vehicles, make == "Acura") %>% filter(hwy == max(hwy)) %>% select(model)
}

# I tried 1,000 repeats but they were all about 1ms apart, so I went for more
time_a_function <- function(some_function){
start_time <- proc.time()
for (i in 1:100000000){
  some_function
  
}
proc.time() - start_time
}

time_a_function(temp_method())
time_a_function(nest_method())
time_a_function(pipe_method())
