
## Script can be run from your working directory by typing - source('Plot3.R') - in the console.

## Read data in from your Working Directory
data <- read.table(pipe("findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt"), header = FALSE, sep = ";",  na.strings = "?")

## Set the column Names
colnames(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                    "Sub_metering_1","Sub_metering_2","Sub_metering_3")

## Split out the Date and Time columns
dates <- (data$Date)
time <- (data$Time)

##Combine the Date and Time column
dt <- paste(dates,time)

## Use strptime to format the new date/time column
g <- strptime(dt, "%d/%m/%Y %H:%M:%S")

## Bring in the Global Sub Meterring columns
sb <- data.frame(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3)

## Change the new data set into a Data Frame from a "form Factor"
pldata <- data.frame(g, sb)

## Set the column Names
colnames(pldata) <- c("Day","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##pldata$Sub_metering_2, pldata$Sub_metering_3,
## Plot the Line Graph
plot(pldata$Day, pldata$Sub_metering_1, type = "n", main = "Sub Metering",
     xlab = "Day of Week", ylab = "Energy Sub Metering")
lines(pldata$Day, pldata$Sub_metering_1, col = "black")
lines(pldata$Day, pldata$Sub_metering_2, col = "red")
lines(pldata$Day, pldata$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Copy the plot to a PNG File and save in your working directory
png(file = "Plot3.png", width = 480, height = 480, units = "px")
plot(pldata$Day, pldata$Sub_metering_1, type = "n", main = "Sub Metering",
     xlab = "Day of Week", ylab = "Energy Sub Metering")
lines(pldata$Day, pldata$Sub_metering_1, col = "black")
lines(pldata$Day, pldata$Sub_metering_2, col = "red")
lines(pldata$Day, pldata$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the PNG device
dev.off()


##Not used
## Copy the plot to a PNG File and save in your working directory
##dev.copy(png, file = "Plot3.png", width = 480, height = 480, units = "px")

## Close the PNG device
##dev.off()