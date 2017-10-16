library(lubridate)

data <- read.table("./exdata/household_power_consumption.txt", 
                   sep=";", na.strings = "?", skip=66637, nrows=2880, 
                   header = FALSE)
names(data)[1:9] = c("Date", "Time", "Global_active_power",
                     "Global_reactive_power","Voltage","Global_intensity",
                     "Sub_metering_1","Sub_metering_2","Sub_metering_3")
dt<-with(data, dmy(Date) + hms(Time))
data$Datetime <- as.POSIXct(dt)

with(data, {
        plot(Global_active_power~Datetime, type = "l",
                ylab = "Global Active Power (kilowatts)", xlab = "")
        })

dev.copy(png,"plot2.png")
dev.off