## data.table ##

## Shortcut Reminder:
# ctrl + enter (or cmnd + enter) to run the line of code your cursor is currently on
# 'tab' to autocomplete, arrow up and down through the options

## install and load data.table
library(data.table)

## read in iris data
iris=fread("~/2022_Adelaide_Code_Club/Lessons/2022/2022_08_11_data.table/iris.txt")

## subset the first 10 rows
iris[1:10]

## subset all rows where Petal.Width is equal to 1.8
iris[Petal.Width==1.8]

## extract just the Species and Petal.Width columns
iris[,.(Species, Petal.Width)]

## extract the Sepal.Width column as a vector
iris[, Sepal.Width]

## count the number of rows for each species
iris[,.N, by=c("Species", "Petal.Width")]

## calculate the mean sepal length per species
iris[, mean(Sepal.Length), by="Species"]

## BONUS QUESTION: Plot petal length vs petal width for only setosa species, using data.table syntax to subset the data
library(ggplot2)

ggplot(iris[Species=="setosa"])+
  geom_point(aes(Petal.Length, Petal.Width, col=Species))

