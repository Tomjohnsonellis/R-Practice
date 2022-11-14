# Exercise 1: accessing a relational database

# Install and load the `dplyr`, `DBI`, and `RSQLite` packages for accessing
# databases
library(dplyr)
library(DBI)
install.packages("RSQLite")
library(RSQLite)
# Create a connection to the `Chinook_Sqlite.sqlite` file in the `data` folder
# Be sure to set your working directory!
setwd("~/GitHub/R-Practice/Exercises/chapter-13")
database_connection <- dbConnect(SQLite(), dbname = "data/Chinook_Sqlite.sqlite")

# Use the `dbListTables()` function (passing in the connection) to get a list
# of tables in the database.
dbListTables(database_connection)

# Use the `tbl()`function to create a reference to the table of music genres.
# Print out the the table to confirm that you've accessed it.
genres <- tbl(database_connection, "Genre")
genres

# Try to use `View()` to see the contents of the table. What happened?
View(genres)
## It opened a popup with a bunch of info about the table's data types(?)
## Not particularly useful to me currently but I imagine it's helpful at some point

# Use the `collect()` function to actually load the genre table into memory
# as a data frame. View that data frame.
df <- collect(genres)
dim(df)

# Use dplyr's `count()` function to see how many rows are in the genre table
count(genres)


# Use the `tbl()` function to create a reference the table with track data.
# Print out the the table to confirm that you've accessed it.
track_data <- tbl(database_connection, "Track")
track_data

# Use dplyr functions to query for a list of artists in descending order by
# popularity in the database (e.g., the artist with the most tracks at the top)
# - Start by filting for rows that have an artist listed (use `is.na()`), then
#   group rows by the artist and count them. Finally, arrange the results.
# - Use pipes to do this all as one statement without collecting the data into
#   memory!
track_data %>%
  filter(!is.na(Composer)) %>%
  group_by(Composer) %>%
  count(Composer) %>%
  arrange(desc(n))

## Tidyverse's excellent grammar does sometimes catch me off-guard,
## I find myself searching "how to count occurrences of x in R" and it's
## literally just count(Thing)

# Use dplyr functions to query for the most popular _genre_ in the library.
# You will need to count the number of occurrences of each genre, and join the
# two tables together in order to also access the genre name.
# Collect the resulting data into memory in order to access the specific row of
# interest
genre_list <- track_data %>%
    filter(!is.na(GenreId)) %>%
    group_by(GenreId) %>%
    count(GenreId) %>%
    arrange(desc(n))

genre_list[1]
## The usual way of accessing fields won't work here, as we are dealing with database objects

left_join(genre_list, genres) %>%
  arrange(desc(n)) %>%
  filter(n == max(n)) %>%
  select(Name)

## I get a bunch of warning messages, but seems to give me the correct result

# Remember to disconnect from the database once you are done with it!
dbDisconnect(database_connection)