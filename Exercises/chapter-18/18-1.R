# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
setwd("~/GitHub/R-Practice/Exercises/chapter-18")
source("data/api.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Matrix" # I'm not sure how to handle spaces in titles yet

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
query <- paste(
  uri,
  resource,
  "?query=", movie_name, 
  "&api-key=", api_key,
  sep=""
  )

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(query)
response_text <- content(response, "text")
response_data <- fromJSON(response_text)

# What kind of data structure did this produce? A data frame? A list?
is.data.frame(response_data) # False
is.list(response_data) # True

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.

### These were being output when the script was source()'d by the notebook
# names(response_data)
# names(response_data$results)
# str(response_data)
# colnames(response_data) # NULL
# response_data$results$headline
# response_data$results$summary_short # "results" seems to be where the info we want is!


# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(response_data$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
library(dplyr)

most_recent_info <- reviews %>%
  arrange(desc(publication_date)) %>%
  filter(publication_date == max(publication_date)) %>%
  select(headline, summary_short, link.url)
  
my_headline <- most_recent_info$headline
my_summary <- most_recent_info$summary_short
my_link <- most_recent_info$link.url

# Create a list of the three pieces of information from above. 
# Print out the list.
my_list <- list(my_headline, my_summary, my_link)
# my_list

# I would check out the review but there's a paywall, what a shame.