##  INTRO TO GGPLOT2 EXERCISES  ##

## Shortcut Reminder:
  # ctrl + enter (or cmnd + enter) to run the line of code your cursor is currently on
  # 'tab' to autocomplete, arrow up and down through the options

## Setting up your workspace
  
  ## load libraries (By loading 'tidyverse', a number of tidyverse packages will be loaded including ggplot2 (listed in console). 
                   # However, you will need to load janitor and readxl separately.)
library(tidyverse)
library(janitor)
library(readxl)

## Import our dataset and clean it up! 
  #(Reminder: you need to fix column names, empty rows, redundant columns and rows, NAs, species values, and the data type of variables)#
df <- read_excel("~/2022_Adelaide_Code_Club/Lessons/2022/2022_04_07_Intro_to_Tidyverse_and_importing_cleaning_tables/iris_real_world.xlsx") %>%
  clean_names() %>%
  remove_empty() %>%
  remove_constant() %>%
  distinct() %>%
  mutate(
    across(.cols=c(1:5), .fns=~as.double(.)))

setosa_names <- c("setosa|Setosa|setosas")
df <- df %>% mutate(species=str_replace_all(string=species, pattern=setosa_names, replacement="setosa"))
df$species %>% unique


## Now that our data is clean, lets get plotting!!

## Create a scatter plot of sepal_length x sepal_width

p <- ggplot(df, aes(x=sepal_length, y=sepal_width, col=species))+    ## specify x and y variables, colour by species
  geom_point() +                                                     ## specify scatter plot
  facet_grid("species") +                                            ## separate plot into facets
  geom_smooth(method="lm") +                                         ## add in linear trend line
  labs(x="Sepal Length", y="Sepal Width") +                          ## clean up labels
  theme(legend.position = "none")                                    ## remove redundant labels in legend


## Create a plot showing the distribution of petal width for each species, remember to tidy your axes.

plot <- ggplot(df, aes(x=sepal_length, y=sepal_width)) + 
  geom_boxplot(aes(col = species))+                                 ## specify boxplot, colour by species
  labs(x="Sepal Length", y="Sepal Width", colour = "Species")       ## change axis and legend titles  (need to use labels from aesthetic)



## Practise saving your plots

ggsave("boxplot.pdf", plot = plot, width = 5, height=5) 
