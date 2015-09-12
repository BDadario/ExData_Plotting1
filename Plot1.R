
## Script can be run from your working directory by typing - source('Plot1.R') - in the console.

## Code to Import Data.
data <- read.table(pipe("findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt"), header = FALSE, sep = ";",  na.strings = "?")

## Set Column Names
colnames(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


## Create Histogram for Plot 1.
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")

## Copy the plot to a PNG File and save in your working directory
dev.copy(png, file = "Plot1.png", width = 480, height = 480, units = "px")
## Close the PNG device
dev.off()