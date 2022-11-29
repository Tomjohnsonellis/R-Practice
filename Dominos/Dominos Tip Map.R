# While working at Domino's I thought it might be fun to collect some data about
# the tips I received on delivery.
# The goal here is to plot the info I have on a map and see what areas give
# the best tips, my data set is pretty limited but hopefully it's enough to make
# a map!
setwd("~/GitHub/R-Practice/Dominos")
library(dplyr)
library(leaflet)
tip_data = read.csv("data/tipinfo.csv")
postcode_data = read.csv("data/ukpostcodes.csv")

# Let's have a look at this postcode data
colnames(postcode_data)
head(postcode_data$postcode)
# Alright, it seems that the postcodes are nicely 8 characters long,
# in UPPERCASE with a space after the 4th character
unique(nchar(postcode_data$postcode))
# Not quite! Some postcodes have 7 characters, some have 6, 
postcode_data %>%
  filter(nchar(postcode) != 8) %>%
  select(postcode)
# Interesting, but not really an issue, all my postcodes are in the BH area
# and are 7 characters long without a space.
# May as well trim the postcode data down.
?grepl # Useful function for pattern matching
dim(postcode_data)

relevant_postcodes <- postcode_data %>%
  mutate(isbh = grepl("BH\\d\\d", postcode)) %>%
  filter(isbh == TRUE)
dim(relevant_postcodes) # Down to <1% of the dataset!

# Removes spaces
relevant_postcodes$postcode <- gsub(" ", "", relevant_postcodes$postcode)

# Make my data uppercase
tip_data$postcode <- toupper(tip_data$postcode)

# Join the datasets together
tip_data <- left_join(tip_data, relevant_postcodes, by = "postcode")
colnames(tip_data)
# Let's keep the data as simple as we can
tip_dataframe <- tip_data %>%
  select(-isbh, -id, -time.on.ticket) %>%
  rename(tipamount = tip.amount)

# Time to plot! 
# Thanks to https://www.latlong.net/
my_store_lat <-  50.744890
my_store_long <- -1.985220

my_map <- leaflet(data = tip_dataframe) %>%
  addProviderTiles(providers$CartoDB.Voyager) %>%
  setView(lng = my_store_long, lat = my_store_lat, zoom = 11)
  
# I wanted to make this prettier, but with my limited dataset it's quite tricky
pal <- colorNumeric(
  palette = "Reds",
  domain = tip_dataframe$tipamount)

my_map %>% addCircles(
  lat = ~latitude,
  lng = ~longitude,
  radius = 200,
  #color = ~pal(tip_dataframe$tipamount)
)

# That'll do for now, Good fun!







