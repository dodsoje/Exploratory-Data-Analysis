library(sqldf)
require(tcltk)

## Read in just the data that is needed

importdata <- read.csv.sql(file="household_power_consumption.txt", sql="SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep=";")

## Convert column names to lower case for easy typing

names(importdata) <- tolower(names(importdata))


## Concatante Date and Time variables 

importdata$DateTime <- strptime(paste(importdata$date, importdata$time, sep=" "), format="%d/%m/%Y %H:%M:%S") 
 

## Perform Plot

png("plot20.png", width=480, height=480)

plot(importdata$DateTime, importdata$global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#plot(importdata$DateTime, importdata$global_active_power, xlab="", ylab="Global Active Power (kilowatts)") 

dev.off()
