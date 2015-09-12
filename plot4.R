library(dplyr)

## load data and format/subset relevant rows
data <- read.csv("household_power_consumption.txt", header=TRUE, sep = ';')
data <- mutate(data, DTchar=paste(Date,Time,sep=" "))
DT <- strptime(data$DTchar, "%d/%m/%Y %H:%M:%S")
data <- cbind(data, DT)
subset <- data[(data$Date == '1/2/2007' | data$Date == '2/2/2007'),   ]
subset <- mutate(subset, GAP_kw = as.numeric(subset$Global_active_power)/1000)

## create and annotate graph
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
with(subset, {
  plot(DT, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", cex.lab=0.75, cex.axis=0.75)
  plot(subset$DT, subset$Voltage, type = "l", ylab= "Voltage", xlab = "datetime", cex.lab=0.75, cex.axis=0.75)
  plot(subset$DT, subset$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering" , cex.lab=0.75, cex.axis=0.75)
  lines(subset$DT, subset$Sub_metering_2, col="red")
  lines(subset$DT, subset$Sub_metering_3, col="blue")
  legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , cex = .5, bty = "n" )
  par(mar = c(4, 4, 2, 1))
  plot(subset$DT, subset$Global_reactive_power, type = "l", xlab= "datetime", ylab= "Global_reactive_power" , cex.lab=0.75, cex.axis=0.75)
})

## save as .png file
dev.copy(png, file = "plot4.png")
dev.off()

