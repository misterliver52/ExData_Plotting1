library(lubridate)

data <- read.table("./exdata/household_power_consumption.txt", 
                   sep=";", na.strings = "?", skip=66637, nrows=2880, 
                   header = FALSE)
names(data)[1:9] = c("Date", "Time", "Global_active_power",
                     "Global_reactive_power","Voltage","Global_intensity",
                     "Sub_metering_1","Sub_metering_2","Sub_metering_3")
dt<-with(data, dmy(Date) + hms(Time))
data$Datetime <- as.POSIXct(dt)

par(mfrow=c(2,2))


#Plot1
with(data, plot(Datetime, as.numeric(as.character(Global_active_power)), 
                type="l", xlab="", ylab="Global Active Power"))
#Plot2
with(data, plot(Datetime, as.numeric(as.character(Voltage)), type="l", 
                xlab="datetime", ylab="Voltage"))

#Plot3
with(data, plot(Datetime, as.numeric(as.character(Sub_metering_1)), type = "l", 
     xlab="", ylab="Energy sub metering", ylim=c(0,40)))
lines(data$Datetime, as.numeric(as.character(data$Sub_metering_2)), 
      col = "red")
lines(data$Datetime, as.numeric(as.character(data$Sub_metering_3)), 
      col = "blue")
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

#Plot4
with(data,plot(Datetime, as.numeric(as.character(Global_reactive_power)), 
               type="l", xlab="datetime", ylab="Global_reactive_power"))


dev.copy(png,'plot4.png')
dev.off
