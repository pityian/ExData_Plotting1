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

#Turn Global active power collumn to mumeric
subdata$Global_active_power <- with(subdata, as.numeric(subdata$Global_active_power))
subdata$Sub_metering_1 <- with(subdata, as.numeric(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- with(subdata, as.numeric(subdata$Sub_metering_2))
subdata$Sub_metering_3 <- with(subdata, as.numeric(subdata$Sub_metering_3))

#Concatenate Date and Time in one value with the apropriate format
DateTime<-as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")

#set png properties
png(filename = "plot3.png",width = 480, height = 480, units = "px")

#make plot 3
with(subdata, plot(DateTime, Sub_metering_1, type="l", xlab=" ", ylab="Energy sub metering"))
lines(DateTime, subdata$Sub_metering_2, col="red")
lines(DateTime, subdata$Sub_metering_3, col="blue")

#add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black","red","blue"))

dev.off()
