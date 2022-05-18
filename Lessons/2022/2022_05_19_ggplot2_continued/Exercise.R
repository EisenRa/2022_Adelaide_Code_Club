## ggplot2 continued ##

## Shortcut Reminder:
# ctrl + enter (or cmnd + enter) to run the line of code your cursor is currently on
# 'tab' to autocomplete, arrow up and down through the options

##today's dataset##
install.packages("tidytuesdayR")
tuesdata <- tidytuesdayR::tt_load(2021, week = 15)  ## Deforestation dataset https://github.com/rfordatascience/tidytuesday/tree/master/data/2021/2021-04-06
soy <- tuesdata$soybean_use

## load pacakges


## filter dataset so you are only looking at the values for the world.


## create line plot of year vs processed


## add in human_food and animal_food lines


## change the colour of each line so they stand out


## add labels to each line


## don't forget to tidy the axes


## actually, this might look better as an area plot...


## save your plot

