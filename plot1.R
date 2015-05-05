#load data set. The .txt file is located in the working directory.
data <- read.table("./household_power_consumption.txt", header = T, sep = ";")

#convert Date column into dates
library(lubridate)
data[1] <- dmy(data[[1]])
data[1] <- as.Date(data[[1]])

#subset columns for only relevant data
data <- data[, c(1,3)]

#subset row data between 2007-02-01 and 2007-02-02
library(dplyr)
data <- filter(data, Date >= "2007-02-01", Date <= "2007-02-02")

#clean up column names
names(data) <- c("Date", "GAP")

#convert GAP data to numeric
data[2] <- as.numeric(as.character(data[[2]]))

#create png file
png("plot1.png", width = 480, height = 480, units = "px")

#create histogram
hist(data$GAP, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

#close
dev.off()