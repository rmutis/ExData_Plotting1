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

# 4. Open png-creation with the plot as input and close the connection afterwards

png(filename = "plot3.png", width = 480, height = 480)
plot(data_filter$date_time, data_filter$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
points(data_filter$date_time, data_filter$Sub_metering_2, type = "l", col = "red")
points(data_filter$date_time, data_filter$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty=1, col = c ("black", "red", "blue"), legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
