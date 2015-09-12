
## Script can be run from your working directory by typing - source('Plot2.R') - in the console.

## Read data in from your Working Directory
data <- read.table(pipe("findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt"), header = FALSE, sep = ";",  na.strings = "?")

## Set the column Names
colnames(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## Split out the Date and Time columns
dates <- (data$Date)
time <- (data$Time)

##Combine the Date and Time column
dt <- paste(dates,time)

## Use strptime to format the new date/time column
g <- strptime(dt, "%d/%m/%Y %H:%M:%S")

## Bring in the Global Active Power column
gap <- data$Global_active_power

## Change the new data set into a Data Frame from a "form Factor"
pdata <- data.frame(g, gap)

## Set the column Names
colnames(pdata) <- c("Day","Global_active_power")

## Plot the Line Graph
plot(pdata$Day, pdata$Global_active_power, type = "n", main = "Global Active Power",
     xlab = "Day of Week", ylab = "Global Active Power (Kilowatts)")
lines(pdata$Day, pdata$Global_active_power)


## Copy the plot to a PNG File and save in your working directory
dev.copy(png, file = "Plot2.png", width = 480, height = 480, units = "px")
## Close the PNG device
dev.off()