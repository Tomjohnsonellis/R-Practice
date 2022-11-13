# Exercise 8: exploring data sets

# Load the `dplyr` library
library(dplyr)

# Read in the data (from `data/pulitzer-circulation-data.csv`). Remember to 
# not treat strings as factors!
setwd("~/GitHub/R-Practice/Exercises/chapter-11")
df <- read.csv("data/pulitzer-circulation-data.csv", stringsAsFactors = FALSE)

# View in the data set. Start to understand what the data set contains
dim(df)
colnames(df)
head(df)
## This seems to be a dataset of newspaper brands, their sales, and how many prizes they have won

# Print out the names of the columns for reference
colnames(df)

# Use the 'str()' function to also see what types of values are contained in 
# each column (you're looking at the second column after the `:`)
# Did any value type surprise you? Why do you think they are that type?
?str ## STRucture of an object, nothing to do with STRings as I first thought!
str(df$Newspaper)
str(df$Daily.Circulation..2004)
str(df$Change.in.Daily.Circulation..2004.2013)
str(df$Pulitzer.Prize.Winners.and.Finalists..1990.2003)
str(df$Pulitzer.Prize.Winners.and.Finalists..2004.2014)
## Daily circulation and Change in daily cicrulation surprised me by being "chr",
## I'm guessing because of the commas and percentage symbols


# Add a column to the data frame called 'Pulitzer.Prize.Change` that contains 
# the difference in the number of times each paper was a winner or finalist 
# (hereafter "winner") during 2004-2014 and during 1990-2003
df <- df %>%
  mutate(Pulitzer.Prize.Change = (Pulitzer.Prize.Winners.and.Finalists..2004.2014 - Pulitzer.Prize.Winners.and.Finalists..1990.2003))


head(df)
# What was the name of the publication that has the most winners between 
# 2004-2014?
df %>%
  filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 == max(Pulitzer.Prize.Winners.and.Finalists..2004.2014)) %>%
  select(Newspaper)
## These column names are a bit longer than what I'm used to, but still usable!


# Which publication with at least 5 winners between 2004-2014 had the biggest
# decrease(negative) in daily circulation numbers?

## There is a column already available for the percentage change in daily circulation,
## However I believe this question wants the actual values.

## I need to convert the text into numbers by removing the commas first
## gsub replaces all the commas at once
df$Daily.Circulation..2004 <- as.numeric(gsub(",", "", df$Daily.Circulation..2004))
df$Daily.Circulation..2013 <- as.numeric(gsub(",", "", df$Daily.Circulation..2013))
df %>%
  mutate(change_in_circulation = Daily.Circulation..2013 - Daily.Circulation..2004) %>%
  filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 >= 5) %>%
  filter(change_in_circulation == min(change_in_circulation)) %>%
  select(Newspaper, Pulitzer.Prize.Winners.and.Finalists..2004.2014,change_in_circulation)

## If the question DID want just the percentage change...
df$Change.in.Daily.Circulation..2004.2013 <- as.numeric(gsub("%","",df$Change.in.Daily.Circulation..2004.2013))
df %>%
  filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 >= 5) %>%
  filter(Change.in.Daily.Circulation..2004.2013 == min(Change.in.Daily.Circulation..2004.2013)) %>%
  select(Newspaper, Pulitzer.Prize.Winners.and.Finalists..2004.2014, Change.in.Daily.Circulation..2004.2013)

# An important part about being a data scientist is asking questions. 
# Write a question you may be interested in about this data set, and then use  
# dplyr to figure out the answer!
## Let's try: "What is the ratio of prizes to sales for each newspaper?"
colnames(df)
df %>%
  filter(Daily.Circulation..2013 > 0, Pulitzer.Prize.Winners.and.Finalists..1990.2014 > 0) %>%
  mutate(prize_ratio = Daily.Circulation..2013 / Pulitzer.Prize.Winners.and.Finalists..1990.2014) %>%
  arrange(prize_ratio) %>%
  select(Newspaper, prize_ratio)
## Washington Post seems to win the most prizes per reader, neat!