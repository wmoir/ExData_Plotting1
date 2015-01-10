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
if (!exists("subset")) {
  full <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, na.strings=c("?"), sep=';')
  subset <- full[full$Date %in% c('1/2/2007','2/2/2007'),]
  rm(full)
  subset$datetime <- paste(subset$Date, subset$Time)
  subset$Date <- as.Date(subset$Date, format="%d/%m/%Y")
  subset$Time <- strptime(subset$datetime, format="%d/%m/%Y %H:%M:%S")
}

## plot 2
png(filename = "./ExData_Plotting1/plot2.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
with(subset, {
  plot(Time, Global_active_power, 
       type='n',
       ylab = 'Global Active Power (kilowatts)',
       xlab = '')
       lines(Time, Global_active_power)
})
dev.off()
