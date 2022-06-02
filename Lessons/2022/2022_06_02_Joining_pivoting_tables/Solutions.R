## You are collaborating with the international institute of dog science (IIDS) on
## a research project. There are many people working on the project, and each has
## their own way of collecting data *facepalm*. In these exercises we will cover
## this real world scenario using some dummy data, with the goal of having a 
## final table containing all metadata for the dogs.

## Load your required packages
library(tidyverse)

## 1: Import the four data files.
df1 <- read_delim("Lessons/2022/2022_06_02_Joining_pivoting_tables/dog_food_walk_data.txt")
df2 <- read_delim("Lessons/2022/2022_06_02_Joining_pivoting_tables/dog_bday_data.txt")
df3 <- read_delim("Lessons/2022/2022_06_02_Joining_pivoting_tables/dog_treats_data.csv")
df4 <- read_delim("Lessons/2022/2022_06_02_Joining_pivoting_tables/dog_weights.csv")

## 2: Let's start by getting the 'dog_food_walk_data.txt' tidied up.
df1_tidy <- df1 %>%
  pivot_wider(., names_from = category, values_from = value)

## 3: Now, let's also tidy up the 'dog_bday_data.txt' file.
df2_tidy <- df2 %>%
  unite(., col = "dog_dob", century_of_birth, year_of_birth, sep = "")

## 4: Next up, the 'dog_treats_data.csv' file. 
df3_tidy <- df3 %>%
  separate(., col = scooby_snacks_per_day_and_puppucinnos_per_day, 
           into = c("scooby_snacks_per_day", "puppucinnos_per_day"),
           convert = TRUE)

## 5: Finally, let's tidy the 'dog_weights.csv' file.
df4_tidy <- df4 %>%
  pivot_longer(., cols = !breed, names_to = "dog_name", values_to = "weight", 
               values_drop_na = TRUE, names_pattern = "(.*)_weight")


## 6: Now we want to combine all these tables into a single table:
final_table <- df1_tidy %>%
  left_join(., df2_tidy, by = c("dog_name" = "doge_name")) %>%
  left_join(., df3_tidy, by = c("dog_name" = "DoG_nAmE")) %>%
  left_join(., df4_tidy, by = "dog_name")
