## Script can be run from your working directory by typing - source('Plot4.R') - in the console.

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

## Setup data for first plot
## Bring in the Global Active Power column
gap <- data$Global_active_power

## Change the new data set into a Data Frame from a "form Factor"
pdata <- data.frame(g, gap)

## Set the column Names
colnames(pdata) <- c("Day","Global_active_power")


## Set up Data for second plot
## put the date and Voltage into a data frame
vol <- data.frame(g, data$Voltage)

## Set the column Names
colnames(vol) <- c("Day","Voltage")

## Setup data for third plot
## Bring in the Global Sub Meterring columns
sb <- data.frame(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3)

## Change the new data set into a Data Frame from a "form Factor"
pldata <- data.frame(g, sb)

## Set the column Names
colnames(pldata) <- c("Day","Sub_metering_1","Sub_metering_2","Sub_metering_3")


## Setup data for fouth plot
## Bring in the Global Active Power column
grp <- data$Global_reactive_power

## Change the new data set into a Data Frame from a "form Factor"
gldata <- data.frame(g, grp)

## Set the column Names
colnames(gldata) <- c("Day","Global_reactive_power")


## Set canvas to hold 4 plots 2x2
par(mfrow = c(2,2))
## Adjust Margings
par(mar = c(4,4,2,2))

## First Chart
## Plot the Global Active Power Line Graph
plot(pdata$Day, pdata$Global_active_power, type = "n", main = "Global Active Power",
     xlab = "Day of Week", ylab = "Global Active Power (Kilowatts)")
lines(pdata$Day, pdata$Global_active_power)


## Second Plot
## Plot the Voltage Line Graph
plot(vol$Day, vol$Voltage, type = "n", main = "Voltage",
     xlab = "Day of Week", ylab = "Voltage")
lines(vol$Day, vol$Voltage)


## Third Chart
##pldata$Sub_metering_2, pldata$Sub_metering_3,
## Plot the Line Graph
plot(pldata$Day, pldata$Sub_metering_1, type = "n", main = "Sub Metering",
     xlab = "Day of Week", ylab = "Energy Sub Metering")
lines(pldata$Day, pldata$Sub_metering_1, col = "black")
lines(pldata$Day, pldata$Sub_metering_2, col = "red")
lines(pldata$Day, pldata$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Fourth Chart
## Plot the Global Reactive power Line chart
plot(gldata$Day, gldata$Global_reactive_power, type = "n", main = "Global Reactive Power",
     xlab = "Day of Week", ylab = "Global Reactive Power")
lines(gldata$Day, gldata$Global_reactive_power)



## Copy the plot to a PNG File and save in your working directory
dev.copy(png, file = "Plot4.png", width = 480, height = 480, units = "px")
## Close the PNG device
dev.off()