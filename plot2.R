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

png(filename = "plot2.png")
plot(ds$Global_active_power~ds$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()