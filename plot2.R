#load data set. The .txt file is located in the working directory.
data <- read.table("./household_power_consumption.txt", header = T, sep = ";")

#convert Date column into dates
library(lubridate)
data[1] <- dmy(data[[1]])
data[1] <- as.Date(data[[1]])

#subset columns for only relevant data
data <- data[, 1:3]

#subset row data between 2007-02-01 and 2007-02-02
library(dplyr)
data <- filter(data, Date >= "2007-02-01", Date <= "2007-02-02")

#clean up column names
names(data) <- c("Date", "Time", "GAP")

#convert GAP data to numeric
data[3] <- as.numeric(as.character(data[[3]]))

#merge Date and Time columns and convert data into Posix
data[2] <- as.character(data[[2]])
data[2] <- paste(data[[1]], data[[2]])
data <- data[, 2:3]
names(data) <- c("DateTime", "GAP")     #fix the column names
data[1] <- ymd_hms(data$DateTime)

#create png file
png("plot2.png", width = 480, height = 480, units = "px")

#create line chart
x <- data$DateTime
y <- data$GAP
plot(x, y, type = "n", xlab = NA, ylab = "Global Active Power (kilowatts")
lines(x, y)

#close
dev.off()