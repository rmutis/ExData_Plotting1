# 0. Check for relevant packages and install or activate them respectively

if(!require("graphics", character.only = TRUE)) {
  install.packages("graphics")
}
if(!require("grDevices", character.only = TRUE)) {
  install.packages("grDevices")
}
library("graphics")
library("grDevices")

# 1. download the file, unzip it and read the information

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="data.zip")
unzip("data.zip")
data_raw <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# 2. Filter only on the necessary data in Date (2007-02-01 and 2007-02-02) 

data_filter <- subset(data_raw, Date == "1/2/2007" | Date == "2/2/2007", select = names(data_raw))

# 3. Put Date and Time together and convert it accordingly

data_filter$date_time <- paste(data_filter$Date, data_filter$Time, sep="-")
data_filter$date_time <- strptime(data_filter$date_time, format = "%d/%m/%Y-%H:%M:%S")

# 4. Open png-creation with various plots as input and close the connection afterwards

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c (2, 2))
with(data_filter, {
  plot(date_time, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
  plot(date_time, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  plot(date_time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
  points(date_time, Sub_metering_2, type = "l", col = "red")
  points(date_time, Sub_metering_3, type = "l", col = "blue")
  legend("topright", pch = 1, col = c ("black", "red", "blue"), legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(date_time, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
  })
dev.off()
