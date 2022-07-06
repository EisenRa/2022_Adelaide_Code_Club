# Install and load the rentrez package
install.packages("rentrez")
library(rentrez)
library(tidyverse)

# What databases are we able to search using rentrez?
entrez_dbs()


# Print a summary of the "sra" database
entrez_db_summary(db = "sra")


# What searchable terms to we have for the "sra" database?
entrez_db_searchable(db = "sra")



output <- entrez_search(db = "pubmed", term = "Eisenhofer R[AUTH] AND (ancient OR wombat)", retmax = 100)


entrez_fetch(db = "pubmed", id = output, rettype = "abstract")


year <- 1922:2022

year_searches <- glue("wombat AND {year}[PDAT]")
                      