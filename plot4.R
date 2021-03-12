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

#combine date and time for plotting
xaxis <- as.POSIXct(paste(chartdata$Date,chartdata$Time))

#plot
windows(width = 12, height = 12)
par(mfrow = c(2,2), mar = c(4,4,4,2), oma = c(1,1,1,1))
plot(xaxis, chartdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(xaxis, chartdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(xaxis, chartdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(xaxis, chartdata$Sub_metering_2, col = "red")
lines(xaxis, chartdata$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red", "blue"), lty = 1)
plot(xaxis, chartdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
dev.copy(png, "plot4.png")
dev.off()