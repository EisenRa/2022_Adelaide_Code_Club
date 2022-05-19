## ggplot2 continued ##

## Shortcut Reminder:
# ctrl + enter (or cmnd + enter) to run the line of code your cursor is currently on
# 'tab' to autocomplete, arrow up and down through the options

##today's dataset##
install.packages("tidytuesdayR")
tuesdata <- tidytuesdayR::tt_load(2021, week = 15)  ## Deforestation dataset https://github.com/rfordatascience/tidytuesday/tree/master/data/2021/2021-04-06
soy <- tuesdata$soybean_use

## load packages
load(tidyverse)

## filter dataset so you are only looking at the values for the world.
df <- soy %>% filter(entity=="World")

## create line plot of year vs processed

ggplot(df, aes(x=year))+
  geom_line(aes(y=processed/1e6), col="blue")+
  
  ## add in human_food and animal_feed lines
  ## change the colour of each line so they stand out
  geom_line(aes(y=human_food/1e6), col="deeppink")+     
  geom_line(aes(y=animal_feed/1e6), col="orange")+
  
  ## add labels to each line
  geom_text(aes(2005, 1, label = "Animal Feed"), 
            col="orange",  size=5)+
  geom_text(aes(2005, 25, label = "Human Food"), 
            col="deeppink",  size=5)+
  geom_text(aes(2005, 130, label = "Processed"), 
            col="blue",  size=5)+
  
  ## don't forget to tidy the axes
  labs(x="Year", y="Quantity (Million Tonnes)")+
  scale_x_continuous(breaks = c(1960, 1970, 1980, 1990, 2000, 2010))

## actually, this might look better as an area plot...

plot <- ggplot(df, aes(x=year))+
  geom_area(aes(y=processed/1e6), fill="blue", alpha=0.2)+
  geom_area(aes(y=human_food/1e6), fill="deeppink", alpha=0.6)+
  geom_area(aes(y=animal_feed/1e6), fill="orange", alpha=0.5)+
  geom_text(aes(1970, 150, label = "Animal Feed"), 
            col="orange",  size=5)+
  geom_text(aes(1970, 180, label = "Human Food"), 
            col="deeppink",  size=5)+
  geom_text(aes(1970, 210, label = "Processed"), 
            col="blue",  size=5)+
  labs(x="Year", y="Quantity (Million Tonnes)")+
  scale_x_continuous(breaks = c(1960, 1970, 1980, 1990, 2000, 2010))


## save your plot
ggsave("plot.pdf", plot, width=6, height=5)
