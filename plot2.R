##plot2.R
#Exploratory Data Analysis Course Project 1
#Please note the dataset "household_power_consumption.txt" should be saved in 
#the working directory.  You could find the link to download the dataset in 
#README.md.

#Read the dataset
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#extract the hpc data for 2007-02-01 and 2007-02-02
hpc <- hpc[(hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007"), ]

#convert the Date and Time variables to Date/Time Classes, and
#integrate these 2 cols into 1 col called Datetime
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
#combine Date and Time and rename Time to Datetime
hpc$Time <- paste(hpc$Date, hpc$Time)
names(hpc)[2] <- "Datetime"
#convert it to Time class POSIXlt
hpc$Datetime <- strptime(hpc$Datetime, "%Y-%m-%d %H:%M:%S")
#remove the Date col
hpc <- hpc[, 2:ncol(hpc)]

#Remove if there are missing data "?" in Global_active_power
hpc <- hpc[hpc$Global_active_power != "?", ]

#plot
#open PNG device, create 'plot2.png' in my working directory
png(filename = "plot2.png")
#convert Global_active_power from Factor to Numeric
hpc$Global_active_power <- 
        as.numeric(levels(hpc$Global_active_power)[hpc$Global_active_power])
#draw the plot
with(hpc, plot(Datetime, Global_active_power, xlab = "", 
               ylab = "Global Active Power (kilowatts)", type = "l"))

dev.off() #close the PNG file device








