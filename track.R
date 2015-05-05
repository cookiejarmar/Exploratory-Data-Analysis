#load data set. The .txt file is located in the working directory.
data <- read.table("./household_power_consumption.txt", header = T, sep = ";")

#convert Date column into dates
library(lubridate)
data[1] <- dmy(data[[1]])
data[1] <- as.Date(data[[1]])

#subset data between 2007-02-01 and 2007-02-02
library(dplyr)
data <- filter(data, Date >= "2007-02-01", Date <= "2007-02-02")

#clean/tidy column names bit
names(data) <- c("Date", "Time", "GAP", "GRP", "Voltage","GI", "SM1", "SM2", "SM3")

#convert data to numeric
for(i in 3:9){
        data[i] <- as.numeric(as.character(data[[i]]))
}


