# Exercise 1: creating data frames

# Create a vector of the number of points the Seahawks scored in the first 4 games
# of the season (google "Seahawks" for the scores!)
## Tom here: I'm pulling the numbers from https://www.seahawks.com/schedule/
seahawk_points <- c(17,7,23,48)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each of the first 4 games of the season
opponent_points <- c(16,27,27,45)

# Combine your two vectors into a dataframe called `games`
games <- data.frame(seahawk_points, opponent_points)

# Create a new column "diff" that is the difference in points between the teams
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
diff <- abs(seahawk_points - opponent_points)
games <- cbind(games, diff)

# Create a new column "won" which is TRUE if the Seahawks won the game
won <- (seahawk_points - opponent_points > 0)
games <- cbind(games, won)

# Create a vector of the opponent names corresponding to the games played
opponent_names <- c("Denver Broncos","San Francisco 49ers","Atlanta Falcons","Detroit Lions")

# Assign your dataframe rownames of their opponents
rownames(games) <- opponent_names

# View your data frame to see how it has changed!
games
