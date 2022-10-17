# Exercise 4: functions and conditionals

# Define a function `is_twice_as_long` that takes in two character strings, and 
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string

### Tom here, got stuck here for a bit, this was always evaluating to true
### as the logic was not implemented correctly, kept in for learning's sake
# is_twice_as_long <- function(string_1, string_2){
#   result <- FALSE
#   if ((nchar(string_1) * 2) >= nchar(string_2)){
#     result <- TRUE
#   }
#   if ((nchar(string_2) * 2) >= nchar(string_1)){
#     result <- TRUE
#   }
#   
#   result
# }

# short <- "5char"
# long <- "12characters"
# 
# is_twice_as_long(short, long)
# is_twice_as_long("short", "short")
# nchar(short)*2 >= nchar(long)

is_twice_as_long <- function(string_1, string_2){
  result <- FALSE
  if (nchar(string_1) >= nchar(string_2) * 2){
    result <- TRUE
  }
  if (nchar(string_2) >= nchar(string_1) * 2){
    result <- TRUE
  }

  result
}



# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
short <- "5char"
long <- "12characters"

is_twice_as_long(short, long)
is_twice_as_long("short", "short")
nchar(short)*2 >= nchar(long)


# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- function(string_1, string_2){
  if (nchar(string_1) > nchar(string_2)){
    difference = nchar(string_1) - nchar(string_2)
    result <- paste("Your first string is longer by",difference,"characters")
  }
  if (nchar(string_2) > nchar(string_1)){
    difference = nchar(string_2) - nchar(string_1)
    result <- paste("Your second string is longer by",difference,"characters")
  }
  
  
  if (nchar(string_1) == nchar(string_2)){
    result <- paste("Your strings are the same length!")
  }
  
  result
}


# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions1
shorter_string <- "short"
longer_string <- "very long string"
describe_difference(shorter_string, longer_string)
describe_difference(longer_string, shorter_string)
describe_difference("four","char")
