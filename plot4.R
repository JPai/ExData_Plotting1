##plot4.R
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

#Remove if there are missing data "?" in Sub_metering_1, 2, 
#and NA in 3, and all related variables
hpc <- hpc[hpc$Sub_metering_1 != "?", ]
hpc <- hpc[hpc$Sub_metering_2 != "?", ]
hpc <- hpc[!is.na(hpc$Sub_metering_3), ]
hpc <- hpc[hpc$Global_active_power != "?", ]
hpc <- hpc[hpc$Voltage != "?", ]
hpc <- hpc[hpc$Global_reactive_power != "?", ]

#plot
#open PNG device, create 'plot4.png' in my working directory
png(filename = "plot4.png")
#convert Sub_metering_1 and 2 from Factor to Numeric
#convert Global_active_power from Factor to Numeric
#convert Voltage from Factor to Numeric
#convert Global_reactive_power from Factor to Numeric
hpc$Sub_metering_1 <- 
        as.numeric(levels(hpc$Sub_metering_1)[hpc$Sub_metering_1])
hpc$Sub_metering_2 <- 
        as.numeric(levels(hpc$Sub_metering_2)[hpc$Sub_metering_2])
hpc$Global_active_power <- 
        as.numeric(levels(hpc$Global_active_power)[hpc$Global_active_power])
hpc$Voltage <- 
        as.numeric(levels(hpc$Voltage)[hpc$Voltage])
hpc$Global_reactive_power <- 
        as.numeric(levels(hpc$Global_reactive_power)[hpc$Global_reactive_power])
#setup par for 4 plots
par(mfcol = c(2, 2))
#draw the first plot
with(hpc, plot(Datetime, Global_active_power, xlab = "", 
               ylab = "Global Active Power", type = "l"))
#draw the second plot
with(hpc, plot(Datetime, Sub_metering_1, type = "l", xlab = "", 
               ylab = "Energy sub metering"))
with(hpc, lines(Datetime, Sub_metering_2, col = "RED"))
with(hpc, lines(Datetime, Sub_metering_3, col = "BLUE"))
#add legend
legend("topright", lty = c(1, 1, 1), col = c("BLACK", "RED", "BLUE"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n")
#draw the third plot
with(hpc, plot(Datetime, Voltage, xlab = "datetime", 
               ylab = "Voltage", type = "l"))
#draw the forth plot
with(hpc, plot(Datetime, Global_reactive_power, xlab = "datetime", 
               type = "l"))

dev.off() #close the PNG file device
