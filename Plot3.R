library(lubridate)

data <- read.table("./exdata/household_power_consumption.txt", 
                   sep=";", na.strings = "?", skip=66637, nrows=2880, 
                   header = FALSE)

names(data)[1:9] = c("Date", "Time", "Global_active_power",
                     "Global_reactive_power","Voltage","Global_intensity",
                     "Sub_metering_1","Sub_metering_2","Sub_metering_3")

dt<-with(data, dmy(Date) + hms(Time))

data$Datetime <- as.POSIXct(dt)

plot(data$Datetime, as.numeric(as.character(data$Sub_metering_1)), type = "l", 
     xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(data$Datetime, as.numeric(as.character(data$Sub_metering_2)), col = "red")
lines(data$Datetime, as.numeric(as.character(data$Sub_metering_3)), col = "blue")
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

dev.copy(png,"plot3.png")
dev.off