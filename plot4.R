#plot 4 for assignment 1, load data, subset, resolve datetime then plot
setClass("myDate")
setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y") )
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses = c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings=c("?"))
summary(power)
str(power)

power2 <- subset(power, Date >= "2007-02-01" & Date <= "2007-02-02")
temp <- paste(power2$Date,power2$Time)
power2$DateTime <- strptime(temp, "%Y-%m-%d %H:%M:%S")

par(mfcol = c(2,2))
plot(power2$DateTime,power2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
with (power2, plot(DateTime,Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering"))
with (power2, lines(DateTime,Sub_metering_2, type="l", col = "red"))
with (power2, lines(DateTime,Sub_metering_3, type="l", col = "blue"))
legend("topright", lty=c(1,1,1) , bty = "n", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with (power2, plot(DateTime,Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with (power2, plot(DateTime,Global_reactive_power, type = "l", xlab = "datetime"))

dev.copy(png,file="plot4.png")
dev.off()
