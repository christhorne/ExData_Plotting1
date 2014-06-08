# This R script assumes that "exdata_data_household_power_consumption.zip" has been downloaded to the current working directory, and unzipped, producing the "household_power_consumption.txt" file. 
# In the following code, "Coursera_DataScienceTrack" is the working directory I'll be using.

# Loads the "household_power_consumption.txt" file into a df called "EnergyData"
EnergyData <- read.table("~/Coursera_DataScienceTrack/household_power_consumption.txt", sep = ";", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings="?", stringsAsFactors = FALSE, as.numeric(3))
# Subsets out the dataset based on the specified date range of 1/2/2007 - 2/2/2007 (dd/mm/yy)
DateSubs <- subset(EnergyData, EnergyData$Date == "1/2/2007" | EnergyData$Date == "2/2/2007")
# Creates a new variable which combines the Date and Time, and converts the data format to "Date"
DateSubs$DateTime <- strptime(paste(DateSubs$Date, DateSubs$Time), format = "%d/%m/%Y %H:%M:%S")


# Sets the graphics device to be a PNG
png("~/Coursera_DataScienceTrack/ExData_Plotting1/plot4.png", width=480, height=480)
# Set up for 4 plots
par(mfrow=c(2,2))
# Creates plot 1 in upper left hand corner
plot(DateSubs$DateTime, DateSubs$Global_active_power, type="l", ylab="Global Active Power", xlab="")
# Create plot 2 in upper right hand corner
plot(DateSubs$DateTime, DateSubs$Voltage, type="l", ylab="Voltage", xlab="datetime")
# Create plot 3 in lower left hand corner
plot(DateSubs$DateTime, DateSubs$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(DateSubs$DateTime, DateSubs$Sub_metering_1, type="l", col="black")
lines(DateSubs$DateTime, DateSubs$Sub_metering_2, type="l", col="red")
lines(DateSubs$DateTime, DateSubs$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", pt.cex=1,cex=.9)
# Create plot 4 in lower right hand corner
plot(DateSubs$DateTime, DateSubs$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
# Closes the PNG device
dev.off()
