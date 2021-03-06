library(dplyr)

## load data and format/subset relevant rows
data <- read.csv("household_power_consumption.txt", header=TRUE, sep = ';', na.strings = "?")
data <- mutate(data, DTchar=paste(Date,Time,sep=" "))
DT <- strptime(data$DTchar, "%d/%m/%Y %H:%M:%S")
data <- cbind(data, DT)
subset <- data[(data$Date == '1/2/2007' | data$Date == '2/2/2007'),   ]
subset <- mutate(subset, GAP_kw = as.numeric(subset$Global_active_power)/1000)

## create and annotate graph
par(mfrow = c(1, 1), mar = c(5.1, 4.1, 4.1, 2.1))
hist(subset$GAP_kw, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col="red", cex.lab=0.75, cex.axis=0.75)

## save as .png file
dev.copy(png, file = "plot1.png")
dev.off()