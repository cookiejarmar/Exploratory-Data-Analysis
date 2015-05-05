#load data set. The .txt file is located in the working directory.
data <- read.table("./household_power_consumption.txt", header = T, sep = ";")

#convert Date column into date class
library(lubridate)
data[1] <- dmy(data[[1]])
data[1] <- as.Date(data[[1]])

#subset columns for only relevant data
data <- data[, c(1, 2, 7, 8, 9)]

#subset row data between 2007-02-01 and 2007-02-02
library(dplyr)
data <- filter(data, Date >= "2007-02-01", Date <= "2007-02-02")

#merge Date and Time columns and convert data into Posix
data[2] <- as.character(data[[2]])
data[2] <- paste(data[[1]], data[[2]])
data <- data[,2:5]
data[1] <- ymd_hms(data[[1]])

#clean up column names
names(data) <- c("DateTime", "SM1", "SM2", "SM3")

#convert SM columns to numeric
data[2] <- as.numeric(as.character(data$SM1))
data[3] <- as.numeric(as.character(data$SM2))
data[4] <- as.numeric(as.character(data$SM3))

#create line chart
a <- data$DateTime
b <- data$SM1
c <- data$SM2
d <- data$SM3
plot(a, b, type = "n", xlab = NA, ylab = "Energy sub metering")
lines(a, b, col = "black")
lines(a, c, col = "red")
lines(a, d, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1), col = c("black", "red", "blue"))

#copy line chart to a PNG file
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()