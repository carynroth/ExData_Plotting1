library(dplyr)

## load data and format/subset relevant rows
data <- read.csv("household_power_consumption.txt", header=TRUE, sep = ';')
data <- mutate(data, DTchar=paste(Date,Time,sep=" "))
DT <- strptime(data$DTchar, "%d/%m/%Y %H:%M:%S")
data <- cbind(data, DT)
subset <- data[(data$Date == '1/2/2007' | data$Date == '2/2/2007'),   ]
subset <- mutate(subset, GAP_kw = as.numeric(subset$Global_active_power)/1000)

## create and annotate graph
plot(subset$DT, subset$Sub_metering_1, type = "l", col = "black" , ylab = "Energy sub metering")
lines(subset$DT, subset$Sub_metering_2, col="red")
lines(subset$DT, subset$Sub_metering_3, col="blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

## save as .png file
dev.copy(png, file = "plot3.png")
dev.off()
