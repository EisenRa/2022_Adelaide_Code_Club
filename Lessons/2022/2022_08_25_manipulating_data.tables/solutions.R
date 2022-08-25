## manipulating data.tables ##

## Shortcut Reminder:
# ctrl + enter (or cmnd + enter) to run the line of code your cursor is currently on
# 'tab' to autocomplete, arrow up and down through the options

## load data.table
library(data.table)

## read in air quality data
DT=fread("~/2022_Adelaide_Code_Club/Lessons/2022/2022_08_25_manipulating_data.tables/airquality.txt")

## subset the data from the month of June
DT[Month==6]

## calculate the mean of the Temp
mean=DT[,mean(Temp)]

## subset all rows where temp is over the mean
DT[Temp>mean]

## add a column to the DT containing the temp in degrees celcius. F to C = (temp in F − 32) × 5/9
DT[, temp_c:=Temp-32 *5/9]

## add two more columns, 1. an identifier of both the date and time and 2. the temperature in K (C to K = temp in C + 273.15)
DT[, ':=' (ID=paste(Day, Month, sep="_"), temp_k=temp_c+273.15)]

## check that Temp is the dame data type as the other temperature values and change it if it isn't
## reassign column name to make the temp in F clear

str(DT)
DT[, temp_f:=as.numeric(Temp)]

## remove the Ozone, Solar.R and Wind columns 
DT[, ':=' (Ozone=NULL, Solar.R=NULL, Wind=NULL, Temp=NULL)]

## extract the mean, median, min, and max of the temperature in C
DT[, .(mean=mean(temp_c), median=median(temp_c), min=min(temp_c), max=max(temp_c))]

