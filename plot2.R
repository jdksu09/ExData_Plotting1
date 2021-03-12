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
xaxis <- as.POSIXct(paste(chartdata$Date,chartdata$Time))

plot(xaxis, chartdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, "plot2.png")
dev.off()