# Exercise 7: using dplyr on external data

# Load the `dplyr` library
library(dplyr)

# Use the `read.csv()` function to read in the included data set. Remember to
# save it as a variable.
setwd("~/GitHub/R-Practice/Exercises/chapter-11")
my_data <- read.csv("data/nba_teams_2016.csv", stringsAsFactors = FALSE)

# View the data frame you loaded, and get some basic information about the 
# number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" following
# the names of teams that made it to the playoffs that year.
?my_data # No info with a plain old csv file!
dim(my_data)
colnames(my_data)
head(my_data)

# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
my_data <- mutate(my_data, TOVSTL = TOV / STL)
colnames(my_data)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest turnover/steal ratio?
my_data <- arrange(my_data, "TOVSTL")
select(filter(my_data, TOVSTL == min(TOVSTL)), Team)

# Using the pipe operator, create a new column of assists per game (AST / G) 
# AND sort the data.frame by this new column in descending order.
my_data <- my_data %>%
  mutate(ASTG = AST / G) %>%
  arrange(desc(ASTG))

head(my_data)
# Create a data frame called `good_offense` of teams that scored more than 
# 8700 points (PTS) in the season
good_offence <- my_data %>%
  filter(PTS > 8700) %>%
  select(Team, PTS)

good_offence
# Create a data frame called `good_defense` of teams that had more than 
# 470 blocks (BLK)
good_defence <- my_data %>%
  filter(BLK > 470) %>%
  select(Team, BLK)

good_defence
# Create a data frame called `offense_stats` that only shows offensive 
# rebounds (ORB), field-goal % (FG.), and assists (AST) along with the team name.
offence_stats <- my_data %>%
  select(Team, ORB, FG., AST)

head(offence_stats)
# Create a data frame called `defense_stats` that only shows defensive 
# rebounds (DRB), steals (STL), and blocks (BLK) along with the team name.
defence_stats <- my_data %>%
  select(Team, DRB, STL, BLK)

head(defence_stats)
# Create a function called `better_shooters` that takes in two teams and returns
# a data frame of the team with the better field-goal percentage. Include the 
# team name, field-goal percentage, and total points in your resulting data frame
better_shooters <- function(team_x, team_y){
  x_stats <- my_data %>%
    filter(Team == team_x) %>%
    select(Team, FG.)
    
  print(x_stats)
  
  y_stats <- my_data %>%
    filter(Team == team_y) %>%
    select(Team, FG.)
  
  print(y_stats)
  
  ## text formatting is not R's strong suit, but still possible!
  text <- "has the better shooters!"
  
  if (x_stats[2] > y_stats[2]){
    sprintf(fmt = "%s %s", x_stats[1], text)
  } else {
    sprintf(fmt = "%s %s", y_stats[1], text)
  }
}

my_data$Team
better_shooters("Miami Heat*", "Chicago Bulls")

# Call the function on two teams to compare them (remember the `*` if needed)
better_shooters("Toronto Raptors*", "Utah Jazz")
