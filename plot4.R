library(sqldf)
require(tcltk)

## Read in just the data that is needed

importdata <- read.csv.sql(file="household_power_consumption.txt", sql="SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep=";")

## Convert column names to lower case for easy typing

names(importdata) <- tolower(names(importdata))


## Concatante Date and Time variables 

importdata$DateTime <- strptime(paste(importdata$date, importdata$time, sep=" "), format="%d/%m/%Y %H:%M:%S") 
 

## Perform Plot


png("plot40.png", width=480, height=480, units="px")
par(mfrow = c(2, 2))

with(importdata, {
plot(importdata$DateTime, importdata$global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(importdata$DateTime, importdata$voltage, type="l", ylab="Voltage", xlab="datetime")

plot(importdata$DateTime, importdata$sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
lines(importdata$DateTime, importdata$sub_metering_2, col="red")
lines(importdata$DateTime, importdata$sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))


plot(importdata$DateTime, importdata$global_reactive_power, type="l", ylab="Gloabl_reactive_power", xlab="datetime")

})

dev.off()

