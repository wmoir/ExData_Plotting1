## Exploratory Data Analysis - Course Project 1
## Plot 2

## Set working directory to my directory for this course
if (!file.exists("./datasciencecoursera")) {dir.create("./datasciencecoursera")}
setwd("datasciencecoursera")

## download and unzip file to datasciencecoursera/cleaning dir
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")) {
  download.file(fileUrl, destfile = "household_power.zip", method = "curl")
  unzip(zipfile = "household_power.zip")
}

# read and subset data, if not already loaded
if (exists("subset")) {
  full <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, na.strings=c("?"), sep=';')
  subset <- full[full$Date %in% c('1/2/2007','2/2/2007'),]
  rm(full)
  subset$datetime <- paste(subset$Date, subset$Time)
  subset$Date <- as.Date(subset$Date, format="%d/%m/%Y")
  subset$Time <- strptime(subset$datetime, format="%d/%m/%Y %H:%M:%S")
}


## Plot 4

png(filename = "./ExData_Plotting1/plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(subset, {
  plot(Time, Global_active_power, 
       type='n',
       ylab = 'Global Active Power',
       xlab = '')
  lines(Time, Global_active_power)
  
  plot(Time, Voltage, 
       type='n',
       ylab = 'Voltage',
       xlab = 'datetime')
  lines(Time, Voltage)
  
  plot(Time, Sub_metering_1, 
       type='n',
       ylab = 'Energy sub metering',
       xlab = '')
  lines(Time, Sub_metering_1)
  lines(Time, Sub_metering_2, col='red')
  lines(Time, Sub_metering_3, col='blue')  
  legend("topright", 
         lty=1,
         bty = "n",
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Time, Global_reactive_power, 
       type='n',
       xlab = 'datetime')
  lines(Time, Global_reactive_power)
})
dev.off()

