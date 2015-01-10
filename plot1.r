## Exploratory Data Analysis - Course Project 1
## Plot 1

## The first part of this code creates the directories, downloads, unzips,
## reads, subsets and transforms the data, but only if each step has not
## already been performed.
## The second part creates the plot

## create directories
if (!file.exists("./datasciencecoursera")) {dir.create("./datasciencecoursera")}
if (!file.exists("./datasciencecoursera/ExData_Plotting1/")) {
  dir.create("./datasciencecoursera/ExData_Plotting1/")
}

## download and unzip file to datasciencecoursera/cleaning dir
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./datasciencecoursera/household_power_consumption.txt")) {
  download.file(fileUrl, destfile = "./datasciencecoursera/household_power.zip", method = "curl")
  unzip(zipfile = "household_power.zip", exdir = "./datasciencecoursera/")
}

# read and subset data, if not already loaded
if (!is.data.frame(subset)) {
  full <- read.table("./datasciencecoursera/household_power_consumption.txt", 
                     header = TRUE, 
                     stringsAsFactors = FALSE, 
                     na.strings=c("?"), 
                     sep=';')
  subset <- full[full$Date %in% c('1/2/2007','2/2/2007'),]
  rm(full)
  subset$datetime <- paste(subset$Date, subset$Time)
  subset$Date <- as.Date(subset$Date, format="%d/%m/%Y")
  subset$Time <- strptime(subset$datetime, format="%d/%m/%Y %H:%M:%S")
}

## plot 1
png(filename = "./datasciencecoursera//ExData_Plotting1/plot1.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
hist(subset$Global_active_power,
     col='red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')
dev.off()




