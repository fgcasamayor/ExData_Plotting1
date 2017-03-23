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
png("plot1.png", width=480, height=480)

#5 Make the graph
with(DT, hist(Global_active_power, 
              col = "red", 
              main = "Global Active",
              xlab = "Global Active Power (kilowatts)")
     )

#6 Close png
dev.off()