# Exercise 2: advanced ggplot2 practice

# Install and load the `ggplot2` package
#install.packages('ggplot2')
library("ggplot2")

# For this exercise you will again be working with the `diamonds` data set.
# Use `?diamonds` to review details about this data set
?diamonds

## Position Adjustments

# Draw a column (bar) chart of diamonds cuts by price, with each bar filled by 
# clarity. You should see a _stacked_ bar chart.
diamonds %>%
  ggplot() +
  geom_col(
    mapping = aes(x = cut, y = price, fill = clarity)
  )

# Draw the same chart again, but with each element positioned to "fill" the y axis
diamonds %>%
  ggplot() +
  geom_col(
    mapping = aes(x = cut, y = price, fill = clarity),
    position = "fill"
  )

# Draw the same chart again, but with each element positioned to "dodge" each other
diamonds %>%
  ggplot() +
  geom_col(
    mapping = aes(x = cut, y = price, fill = clarity),
    position = "dodge"
  )

# Draw a plot with point geometry with the x-position mapped to `cut` and the 
# y-position mapped to `clarity`
# This creates a "grid" grouping the points
diamonds %>%
  ggplot() +
  geom_point(
    mapping = aes(x = cut, y = clarity)
  )

# Use the "jitter" position adjustment to keep the points from all overlapping!
# (This works a little better with a sample of diamond data, such as from the 
# previous exercise).
diamonds %>%
  ggplot() +
  geom_point(
    mapping = aes(x = cut, y = clarity),
    position = "jitter"
  )

diamonds %>% sample_n(1000) %>%
  ggplot() +
  geom_point(
    mapping = aes(x = cut, y = clarity),
    position = "jitter"
  )

## Scales

# Draw a "boxplot" (with `geom_boxplot`) for the diamond's price (y) by color (x)
diamonds %>%
  ggplot() +
  geom_boxplot(
    mapping = aes(x = color, y = price)
  )

# This has a lot of outliers, making it harder to read. To fix this, draw the 
# same plot but with a _logarithmic_ scale for the y axis.
diamonds %>%
  ggplot() +
  geom_boxplot(
    mapping = aes(x = color, y = price)
  ) +
  scale_y_log10()

# For another version, draw the same plot but with `violin` geometry instead of 
# `boxplot` geometry!
# How does the logarithmic scale change the data presentation?
diamonds %>%
  ggplot() +
  geom_violin(
    mapping = aes(x = color, y = price)
  ) +
  scale_y_log10()
## The log scale definitely makes it look prettier, and also makes the differences
## between each colour more noticeable


# Another interesting plot: draw a plot of the diamonds price (y) by carat (x), 
# using a heatmap of 2d bins (geom_bin2d)
# What happens when you make the x and y channels scale logarithmically?
diamonds %>%
  ggplot() +
  geom_bin2d(
    mapping = aes(x = carat, y = price)
  )


diamonds %>%
  ggplot() +
  geom_bin2d(
    mapping = aes(x = carat, y = price)
  ) +
  scale_x_log10() +
  scale_y_log10()

## Scaling both axes logarithmically highlights how the majority of prices are 
## towards the middle of the maximum and minimum prices for each carat,
## makes sense!

# Draw a scatter plot for the diamonds price (y) by carat (x). Color each point
# by the clarity (Remember, this will take a while. Use a sample of the diamonds 
# for faster results)
diamonds %>%
  ggplot() +
  geom_point(
    mapping = aes(x = carat, y = price, color = clarity)
  )

# Change the color of the previous plot using a ColorBrewer scale of your choice. 
# What looks nice?
diamonds %>%
  ggplot() +
  geom_point(
    mapping = aes(x = carat, y = price, color = clarity)
  ) +
  scale_color_brewer(palette = "RdBu")

## There are 3 types of colour palette, for this particular graph they look:
## Sequential: Eyesore
## Divergent: Messy but does show the differences in clarity
## Qualitative: Cleaner, but harder to see middle values
## Remembering that the goal of graphs is to communicate information effectively,
## I'd go for the qualitative style of graph here, the middle values are a bit
## messy but I think this palette best shows the more interesting values.

## Coordinate Systems

# Draw a bar chart with x-position and fill color BOTH mapped to cut
# For best results, SET the `width` of the geometry to be 1 (fill plot, no space
# between)
# TIP: You can save the plot to a variable for easier modifications
my_plot <- diamonds %>%
  ggplot() +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    width = 1
  )

my_plot
# Draw the same chart, but with the coordinate system flipped
my_plot + coord_flip()

# Draw the same chart, but in a polar coordinate system. It's a Coxcomb chart!
my_plot + coord_polar()
## I quite like this one, visually interesting!
## The count axis makes no sense now as with this type of chart the
## area of each segment is determined by the value, not the radius.

## Facets

# Take the scatter plot of price by carat data (colored by clarity) and add 
# _facets_ based on the diamond's `color`
diamonds %>%
  ggplot() +
  geom_point(
    mapping = aes(x = carat, y = price, color = clarity)
  ) +
  scale_color_brewer(palette = "RdBu") +
  facet_wrap(~color)
## Neat, a different graph for each colour, all with a single command.

## Saving Plots

# Use the `ggsave()` function to save the current (recent) plot to disk.
# Name the output file "my-plot.png".
# Make sure you've set the working directory!!
ggsave("my_plot.png")
## It may not be the greatest graph, but I'm still happy to save it.