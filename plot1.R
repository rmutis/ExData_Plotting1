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

# 3. Open png-creation with the histogram as input and close the connection afterwards

png(filename = "plot1.png", width = 480, height = 480)
hist(data_filter$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
