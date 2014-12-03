# load data into data frame, reduce dataset, resolve data frame, plot graph and export graphic
setClass("myDate")
setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y") )
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses = c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings=c("?"))
summary(power)
str(power)

power2 <- subset(power, Date >= "2007-02-01" & Date <= "2007-02-02")
temp <- paste(power2$Date,power2$Time)
power2$DateTime <- strptime(temp, "%Y-%m-%d %H:%M:%S")

with (power2, plot(DateTime,Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering"))
with (power2, lines(DateTime,Sub_metering_2, type="l", col = "red"))
with (power2, lines(DateTime,Sub_metering_3, type="l", col = "blue"))
legend("topright", lty=c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,file="plot3.png")
dev.off()
