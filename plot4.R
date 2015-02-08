#Make use of dplyr package
library(dplyr)

#Read data
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)
data2 <- tbl_df(data)

#subset the data to keep those dates we want
subdata <- filter(data2, Date=="1/2/2007" | Date=="2/2/2007")

#delete unused objects
rm(data)
rm(data2)

#Turn collumns from character to mumeric
subdata$Global_active_power <- with(subdata, as.numeric(subdata$Global_active_power))
subdata$Voltage <- with(subdata, as.numeric(subdata$Voltage))
subdata$Sub_metering_1 <- with(subdata, as.numeric(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- with(subdata, as.numeric(subdata$Sub_metering_2))
subdata$Sub_metering_3 <- with(subdata, as.numeric(subdata$Sub_metering_3))
subdata$Global_reactive_power <- with(subdata, as.numeric(subdata$Global_reactive_power))

#Concatenate Date and Time in one value with the apropriate format
DateTime<-as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")

#set png properties
png(filename = "plot4.png",width = 480, height = 480, units = "px")

#set plot rows and collumns
par(mfcol = c(2,2))

#make plot 1
with(subdata, plot(DateTime, Global_active_power, type="l", xlab=" ", ylab="Global active power"))

#make plot 2
with(subdata, plot(DateTime, Sub_metering_1, type="l", xlab=" ", ylab="Energy sub metering"))
lines(DateTime, subdata$Sub_metering_2, col="red")
lines(DateTime, subdata$Sub_metering_3, col="blue")

#add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lwd=2, bty="n", col=c("black","red","blue"))

#make plot 3
with(subdata,plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

#make plot 4
with(subdata, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()