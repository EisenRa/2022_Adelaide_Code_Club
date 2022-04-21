### Solutions for the second lessons on cleaning table data
###Raphael Eisenhofer 2022

## REMINDER:
# Here are some useful ways of getting around the R Studio (or even BASH terminal)
# 'Tab' will try to autocomplete commands you are typing, saving you time!
# Once you hit 'Tab', you can choose the option with 'up' or 'down' arrow
# 'Ctrl + Enter' (or 'Control/Command + Enter' for Mac) will run the code from the line
# that your cursor is on!


## Initial setup
#Load libraries
library(tidyverse)
library(readxl)
library(janitor)

#Import the table data file from last lesson and do the initial cleaning with janitor
df <- read_excel("Lessons/2022/2022_04_07_Intro_to_Tidyverse_and_importing_cleaning_tables/iris_real_world.xlsx") %>%
  clean_names() %>%
  remove_empty() %>%
  remove_constant() %>%
  distinct()

##1: Fixing mislabeled values in the 'species' column:
#1.1: How many unique categories of 'species' are there in the table? Print them.
df %>%
  group_by(species) %>%
  summarise(n = n())

#1.2: Create a character vector of the offending variable names
troublesome_setosas <- c("setosas|Setosa")

#1.3: Use mutate and str_replace_all to rename the offending variables
df_fixed_setosa <- df %>%
  mutate(species = str_replace_all(species, troublesome_setosas, "setosa"))

#1.4: Check how many unique categories there are of 'species' again 
df_fixed_setosa %>%
  group_by(species) %>%
  summarise(n = n())

#2: We need to change the value types for our numerical columns!
#Mutate across the first 5 columns in our dataframe, converting to data type to
#<dbl> and getting rid of pesky NA values at the same time
#Note you will get warnings, that is OK.
df_fixed_setosa <- df_fixed_setosa %>%
  mutate(
    across(
      c(1:5),
      ~ as.double(.)
    )
  )

#2.1: Calculate the mean sepal_length for each species [hint: group_by() and summarise()]
df_fixed_setosa %>%
  group_by(species) %>%
  summarise(mean = mean(sepal_length))

#3: Create a new column that is sepal_length * sepal_width [hint: use mutate()]
df_fixed_setosa <- df_fixed_setosa %>%
  mutate(sepal_length_X_width = sepal_length * sepal_width)
