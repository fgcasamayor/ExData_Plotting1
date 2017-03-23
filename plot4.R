rm(list = ls())
setwd("C:/RWD/C4/W1/CP1/ExData_Plotting1")

library(data.table)
library(lubridate)

#1 Read the data file
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   stringsAsFactors = FALSE,
                   dec = "."
                   )

#2 Transform to DT and subset by dates
DT <- data.table(data)[Date == "1/2/2007" | Date == "2/2/2007"]

#3 Transform date and time to R standard with lubridate, and other variables to numeric
DT[, ':=' (datetime = dmy_hms (paste(Date, Time)),
           Global_active_power = as.numeric(Global_active_power),
           Global_reactive_power = as.numeric(Global_reactive_power),
           Voltage = as.numeric(Voltage),
           Global_intensity = as.numeric(Global_intensity),
           Sub_metering_1 = as.numeric(Sub_metering_1),
           Sub_metering_2 = as.numeric(Sub_metering_2)
           )
   ]

#4 Open png
png("plot4.png", width=480, height=480)

#5 Arrange graph position in device
par(mfrow = c(2,2))

#6 Make graphs

#6.1 Graph 1 (Top left)
with(DT, plot(datetime, 
              Global_active_power, 
              type="l", 
              xlab="",
              ylab="Global Active Power"
              )
     )

#6.2 Graph 2 (Top right)

with(DT, plot(datetime, 
              Voltage, 
              type="l"
              )
     )

#6.3 Graph 3 (Bottom left)

plot(DT$datetime,
     DT$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering"
     )

lines(DT$datetime,
     DT$Sub_metering_2,
     col = "red"
     )

lines(DT$datetime,
      DT$Sub_metering_3,
      col = "blue"
      )

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       bty = "n"
       )

#6.4 Graph 4 (Bottom right)

with(DT, plot(datetime, 
              Global_reactive_power, 
              type="l"
              )
     )

#7 Close png
dev.off()