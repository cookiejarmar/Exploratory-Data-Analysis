#load data set. The .txt file is located in the working directory.
data <- read.table("./household_power_consumption.txt", header = T, sep = ";")

#convert Date column into date class
library(lubridate)
data[1] <- dmy(data[[1]])
data[1] <- as.Date(data[[1]])

#subset row data between 2007-02-01 and 2007-02-02
library(dplyr)
data <- filter(data, Date >= "2007-02-01", Date <= "2007-02-02")

#merge Date and Time columns and convert data into Posix
data[2] <- as.character(data[[2]])
data[2] <- paste(data[[1]], data[[2]])
data <- data[,2:9]
data[1] <- ymd_hms(data[[1]])

#clean up column names
names(data) <- c("DateTime", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")

#convert columns 2:8 to numeric
for(i in 2:8){
        data[i] <- as.numeric(as.character(data[[i]]))
}

#create png file
png("plot4.png", width = 480, height = 480, units = "px")

#set up the parameters for four plots on what graphic interface
par(mfcol = c(2, 2), bg = "white")

#create 1st plot
a <- data$DateTime
b <- data$GAP
plot(a, b, type = "n", xlab = NA, ylab = "Global Active Power")
lines(a, b)

#create 2nd plot
c <- data$DateTime
d <- data$SM1
e <- data$SM2
f <- data$SM3
plot(c, d, type = "n", xlab = NA, ylab = "Energy sub metering")
lines(c, d, col = "black")
lines(c, e, col = "red")
lines(c, f, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1), col = c("black", "red", "blue"))

#create 3rd plot
g <- data$DateTime
h <- data$Voltage
plot(g, h, type = "n", xlab = "datetime", ylab = "Voltage")
lines(g, h)

#create 4th plot
j <- data$DateTime
k <- data$GRP
plot(j, k, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(j, k)


#close
dev.off()