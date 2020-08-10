library(magrittr)
library(dplyr)
library(lubridate)

header <- read.table("household_power_consumption.txt", sep = ";", nrows = 1) %>% unlist()
ds <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                 skip = 66637, col.names = header, nrows = 2880,
                 colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
ds <- ds[complete.cases(ds),]
ds <- paste(ds$Date, ds$Time) %>%  dmy_hms() %>% cbind(ds)
names(ds)[1] <- "dateTime"

png(filename = "plot4.png")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(ds, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()