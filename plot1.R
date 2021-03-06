### Load data for power infomation, resolve datetime, plot histogram and output png file
setClass("myDate")
setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y") )
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses = c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings=c("?"))
summary(power)
str(power)

power2 <- subset(power, Date >= "2007-02-01" & Date <= "2007-02-02")
temp <- paste(power2$Date,power2$Time)
power2$DateTime <- strptime(temp, "%Y-%m-%d %H:%M:%S")

hist(power2$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

dev.copy(png,file="plot1.png")
dev.off()
