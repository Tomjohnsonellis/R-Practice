library(dplyr)
library(ggplot2)
library(tidyr)

# I'll be using the HairEyeColor dataset, it contains data about 
# hair and eye colour for ~600 statistics students.
?HairEyeColor
dim(HairEyeColor) # 4 x 4 x 2? Seems pretty small
colnames(HairEyeColor)
head(HairEyeColor)
# Ok, it's 2 tables of 4x4
# I'll split the data into 2 dataframes, one for each gender
male <- HairEyeColor[,,1] %>% data.frame(stringsAsFactors = FALSE)
female <- HairEyeColor[,,2] %>% data.frame(stringsAsFactors = FALSE)

# dplyr has transformed the data into "long" form, which will help me work with the data
# I'm not sure how to work with 3d dataframes just yet, so I will combine
# the data I just split up into a format I'm familiar with.
df = male %>%
  mutate(Femfreq = female$Freq) %>%
  mutate(Totfreq = Freq + Femfreq) %>%
  rename(Malefreq = Freq) # Clearer column name

# Let's do a plot of the blue eyed students
blues <- df %>%
  filter(Eye == "Blue") %>%
  select(-Eye) %>% # No need for this column if we're only looking at blue eyes
  rename(Hair = Hair, Male = Malefreq, Female = Femfreq, Total = Totfreq) %>%
  pivot_longer(cols = 2:4, names_to = "Sex", values_to = "Count") %>%
  filter(Sex != "Total")

blues

blue_graph <- blues %>%
  ggplot() +
  geom_col(
    mapping = aes(x = Hair, y = Count, fill = Sex)
  )

blue_graph <- blue_graph +
  labs(
    x = "Hair Colour",
    y = "Blue Eyes",
    title = "Blue eyes for each hair colour",
    subtitle = "Split by sex"
    )


## Getting the labels exactly where I want them proved to be a bit of a challenge
## This doesn't make it clear which each value is.
# blue_graph <- blue_graph +
#   geom_text(
#     mapping = aes(
#       x= Hair,
#       y= Count,
#       label= Sex
#     )
#   )

# Instead I think it would be best to label each sex individually
# This is probably a terrible way of doing this, but it's the best I can do
# with my current knowledge

male_blue <- blues %>%
  filter(Sex == "Male")

blue_graph <- blue_graph +
  geom_text(
    data = male_blue,
    mapping = aes(
      x = Hair,
      y = Count / 2,
      label = Count
    )
  )


fem_blue <- blues %>%
  filter(Sex == "Female") %>%
  mutate(Total = Count + male_blue$Count)


blue_graph <- blue_graph + 
  geom_text(
    data = fem_blue,
    mapping = aes(
      x = Hair,
      y = Total * 0.8,
      label = Count
    )
  )

# And there we go! The labels are just where I want them.
blue_graph
ggsave("blue_eyed_beauties.png")





