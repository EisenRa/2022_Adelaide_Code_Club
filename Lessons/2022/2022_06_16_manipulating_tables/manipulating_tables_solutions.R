##  EXERCISES: MANIPULATING TABLES 16/06/22   ##

## Shortcut Reminder:
# ctrl + enter (or cmnd + enter) to run the line of code your cursor is currently on
# 'tab' to autocomplete, arrow up and down through the options

## load packages ##

library(tidyverse)


## load data ##

df1 <- read_delim("~/2022_Adelaide_Code_Club/Lessons/2022/2022_06_16_manipulating_tables/test_results.txt", delim="\t")
df2 <- read_delim("~/2022_Adelaide_Code_Club/Lessons/2022/2022_06_16_manipulating_tables/test_results_online.txt", delim="\t")

## reformat test results so they are comparable
df1_fixed <- df1 %>% pivot_wider(names_from = category, values_from=value) %>% separate( col="test_1/test_2", into=c("test_1", "test_2"), sep="/") %>% 
  mutate(across(.cols = starts_with("test"), .fns = as.numeric))

##check if the two data frames are the same
setequal(df1_fixed, df2)
## compare the datasets to see what rows are shared and what are not.
intersect(df1_fixed, df2)

setdiff(df1_fixed, df2)

##what do all the rows from both tables look like together
union(df1_fixed, df2)

## looks like theres an error in one of the tables, assume the test_results.txt values are correct for alfie's data 
##use the join functions to decide on the best join for the data
semi_join(df1_fixed, df2,by="name")
semi_join(df2, df1_fixed, by="name")
anti_join(df2,df1_fixed, by="name")
anti_join(df1_fixed,df2, by="name")

## join the two datasets so that we have test results for all 6 individuals
df <- left_join(df1_fixed,df2, by=NULL) %>% distinct()

##extract the data for test 1 to calculate the mean score
test_1_av <- pull(df, var="test_1") %>% mean()

##extract test 4 for as a table with the students names 
test_4 <- df %>% select(name, test_4)
