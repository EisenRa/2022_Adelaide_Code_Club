### Combining the functions we learned to fix our NA issue
###Raphael Eisenhofer 2022

## Initial setup
#Load libraries
library(tidyverse)
library(readxl)
library(janitor)

#Import the data file and do initial cleaining
#Assumes your working directory is the 2022_Adelaide_Code_Club folder
df <- read_excel("Lessons/2022/2022_04_07_Intro_to_Tidyverse_and_importing_cleaning_tables/iris_real_world.xlsx") %>%
  clean_names() %>%
  remove_empty() %>%
  remove_constant() %>%
  distinct()

#Create a vector containing the patterns of the troublesome NAs
troublesome_nas <- c("NA|N/A|na|n/a|unknown")
  
#Use mutate, across, and str_replace_all to fix these values
#Note the ~ is required here (purr-style lambda) as we want to do something in each column
#Note NA_character_ is special, as it lets R know to use a NA value (not a character string)
df_NAs_fixed <- df %>% 
                  mutate(
                    across(
                      .cols = everything(),
                      .fns = ~ str_replace_all(
                        string = ., 
                        pattern = troublesome_nas, 
                        replacement = NA_character_
                      )
                    )
                  )


#We now have to fix the variable types in our tibble -- as they are all <chr> now.
#Note as.double changes our <chr> to <dbl>, as.Date changes to <date>
df_NAs_fixed <- df_NAs_fixed %>%
                            mutate(
                              across(
                                .cols = c(1:5),
                                .fns = as.double
                              ),
                              date_collected = as.Date(date_collected)
                            )

#I realised that there is another road to get to where we want -- perhaps the better solution!
#Here we are just mutating across all columns with the as.double() function. Non numbers seem
#to be converted into proper NAs automatically!
#Note: the c(1:5) tells across to target the first 5 columns (numbers in our data frame).
df_NAs_fixed2 <- df %>%
  mutate(
    across(
      c(1:5),
      ~ as.double(.)
    )
  )




