# Exercise 1: creating and accessing lists

# Create a vector `my_breakfast` of everything you ate for breakfast
my_breakfast <- c("Apple","Banana","Cherry","Dr Pepper")

# Create a vector `my_lunch` of everything you ate (or will eat) for lunch
my_lunch <- c("Egg","Frankfurter","Grape","Hoagie")

# Create a list `meals` that has contains your breakfast and lunch
meals <- list(
  "breakfast" = my_breakfast,
  "lunch" = my_lunch
)

# Add a "dinner" element to your `meals` list that has what you plan to eat 
# for dinner
meals$dinner = c("Ink","Juice","Kool-aid","Lemon")

# Use dollar notation to extract your `dinner` element from your list
# and save it in a vector called 'dinner'
dinner <- meals$dinner

# Use double-bracket notation to extract your `lunch` element from your list
# and save it in your list as the element at index 5 (no reason beyond practice)
meals[[5]] <- meals[["lunch"]]

# Use single-bracket notation to extract your breakfast and lunch from your list
# and save them to a list called `early_meals`
early_meals <- meals[c("breakfast","lunch")]


### Challenge ###

# Create a list that has the number of items you ate for each meal
# Hint: use the `lappy()` function to apply the `length()` function to each item
item_counts <- lapply(meals, length)

# Write a function `add_pizza` that adds pizza to a given meal vector, and
# returns the pizza-fied vector
add_pizza <- function(list_vector){
  pizzafied <- c(list_vector, "Pizza")
  pizzafied
}

add_pizza(meals$breakfast)

# Create a vector `better_meals` that is all your meals, but with pizza!
better_meals <- c(add_pizza(meals$breakfast),add_pizza(meals$lunch),add_pizza(meals$dinner))

# I also made a list version
better_meals <- list(
  "breakfast" = add_pizza(meals$breakfast),
  "lunch" = add_pizza(meals$lunch),
  "dinner" = add_pizza(meals$dinner)
)
                  