# Exercise 2: working with data APIs

# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
setwd("~/GitHub/R-Practice/Exercises/chapter-14")
source("apikey.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "American_Psycho"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
##### The api documentation has changed since the book has been published,
##### Documentation is available now at: https://developer.nytimes.com/docs/movie-reviews-api/1/overview

## https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=godfather&api-key=yourkey

request <- paste0("https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=",movie_name,"&api-key=",apikey)
request
# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(request)

# What kind of data structure did this produce? A data frame? A list?
content <- fromJSON(content(response, "text"))
is.list(content)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
str(content)
names(content$results)

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(content$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
### This movie seems to have only 1 review, so will pull data from that
print("----")
colnames(reviews)
my_headline <- reviews$headline
my_summary <- reviews$summary_short
my_link <- reviews$link.url

# Create a list of the three pieces of information from above. 
# Print out the list.
my_list <- list(my_headline, my_summary, my_link)
print(my_list)
