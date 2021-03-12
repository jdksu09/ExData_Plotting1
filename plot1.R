#read in data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

#Convert columns 3 to 9 to numeric
numdata <- as.data.frame(sapply(data[,3:9], as.numeric))

#Convert date column to date format
date <- as.Date(data$Date, format = "%d/%m/%Y")

#Convert time column to time format
library(chron)
dT <- as.data.frame(chron(times. = data$Time))


#Combine date, time and numdata
columns <- c("Date", "Time", colnames(numdata))
fulldata <- cbind(date, dT, numdata)
colnames(fulldata) <- columns

#Subset by date

chartdata <- fulldata[fulldata$Date >= "2007-02-01" & fulldata$Date <= "2007-02-02",]

#Histogram of global active power variable
hist(chartdata$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.copy(png, "plot1.png")
dev.off()