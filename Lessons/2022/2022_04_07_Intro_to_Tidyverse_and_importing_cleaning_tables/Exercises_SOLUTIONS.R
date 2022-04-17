### Introduction to the Tidyverse & importing/cleaning tables
### 
### Raphael Eisenhofer, 07_04_2022

## 1. Install and then load the "tidyverse" package.
install.packages("tidyverse")
library(tidyverse)

## 2. Install and then load the "janitor" package.
install.packages("janitor")
library(janitor)

## 3. Load the "readxl" package (it is bundled within "tidyverse", but not automatically loaded).
library(readxl)

## 4. Create a vector of length 5, then get the sum of the vector, then get the square root of this. 
vector <- c(5, 5, 5, 5, 5)
vector_sum <- sum(vector)
sqrt(vector_sum)

## 5. Do the same as 4. but with pipes! %>%
vector %>%
  sum() %>%
  sqrt()

## 6. Import the "iris_real_world.xlsx" excel sheet into a variable in R
df <- read_excel("Lessons/2022/2022_04_07_Intro_to_Tidyverse_and_importing_cleaning_tables/iris_real_world.xlsx")

## 7. Clean the column headers
df <- clean_names(df)

## 8. Remove empty rows
df <- remove_empty(df)

## 9. Remove useless columns
df <- remove_constant(df)

## 10. Find any duplicate entries
get_dupes(df)

## 11. Remove any duplicate entries by using the distinct() function
df <- distinct(df)

## 12. BONUS: do steps 6.-> 11. using pipes!!! (note, don't bother with step 10)
df_piped <- read_excel("Lessons/2022/2022_04_07_Intro_to_Tidyverse_and_importing_cleaning_tables/iris_real_world.xlsx") %>%
  clean_names() %>%
  remove_empty() %>%
  remove_constant() %>%
  distinct()

## 13. Print a summary of your clean(er) table!
df_piped

