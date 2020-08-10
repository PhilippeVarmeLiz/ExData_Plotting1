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

png(filename = "plot3.png")
with(ds, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()