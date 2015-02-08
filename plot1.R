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

#make plot 1
hist(subdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

#set png properties
png(filename = "plot1.png",width = 480, height = 480, units = "px")

#copy and extract to png file
dev.copy(png, file="plot1.png")
dev.off()