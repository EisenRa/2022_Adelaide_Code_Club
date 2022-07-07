# Install and load the rentrez package, and load tidyverse and glue
install.packages("rentrez")
library(rentrez)
library(tidyverse)
library(glue)

# What databases are we able to search using rentrez?
entrez_dbs()


# Print a summary of the "pubmed" database
entrez_db_summary(db = "pubmed")


# What searchable terms to we have for the "pubmed" database?
entrez_db_searchable(db = "pubmed")


# Search for all wombat-associated publications in pubmed (save it as a variable)
output <- entrez_search(db = "pubmed", term = "wombat)")

#Explore the list you saved as a variable. How many wombat publications are there?


# Fetch the abstracts for your search. 
entrez_fetch(db = "pubmed", id = output, rettype = "abstract")


# Create a vector with range 1952 to 2021
year <- 1952:2021


# Use glue to create a search term for wombat AND year of publication
wombats <- glue("wombat AND {year}[PDAT]")


#Combine the list of search terms with map_dbl() to iterate rentrez searches
search_results_wombats <- tibble(year = year, wombats_counts = wombats) %>%
  mutate(wombats = map_dbl(wombats, ~entrez_search(db = "pubmed", term = .x)$count))


#Plot your results as a line graph using ggplot2
search_results_wombats %>%
  ggplot(aes(x = year, y = wombats)) +
  geom_line()


#BONUS: compare the number of wombat publications through time to another animal of your choice
bilbys <- glue("bilby AND {year}[PDAT]")

search_results <- tibble(year = year,
                         wombats_counts = wombats,
                         bilby_counts = bilbys) %>%
  mutate(wombats = map_dbl(wombats, ~entrez_search(db = "pubmed", term = .x)$count),
         bilbys = map_dbl(bilbys, ~entrez_search(db = "pubmed", term = .x)$count)
         )

search_results %>%
  select(year, wombats, bilbys) %>%
  pivot_longer(-year) %>%
  ggplot(aes(x = year, y = value, group = name, colour = name)) +
  geom_line()
