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

#Concatenate Date and Time in one value with the apropriate format
DateTime<-as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")

#set png properties
png(filename = "plot2.png",width = 480, height = 480, units = "px")

#make plot 2
with(subdata,plot(DateTime,Global_active_power, type="l", xlab=" ", ylab="Global active power (kilowatts)"))

dev.off()