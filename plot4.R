# create a temp folder for file download
temp <- tempfile()

# download file to temp folder location
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

# unzip and read the file with header and separator ';'
data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";")

# delete the temp file
unlink(temp)

# set the data format before filtering for two days
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# filter for 2 days
data <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

# format all data types before the plotting
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_intensity <- as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# PLOT 4

# merge Date and Time to create a new TimeStamp column
data$ts <- paste(data$Date, data$Time, sep=" ")

# get the data type converted to TimeStamp
data$ts <- as.POSIXct(data$ts, "%Y-%m-%d %H:%M:%S", tz="EST")

# split the canvas to 2 x 2 - rows and columns
par(mfrow=c(2,2))

# Top-Left Plot-1
plot(data$ts,data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Top-Right Plot-2
plot(data$ts,data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Bottom-Left - Plot-3
plot(data$ts,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$ts,data$Sub_metering_2,col="red")
lines(data$ts,data$Sub_metering_3,col="blue")

legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1), bty="n", cex=.3)

# Bottom-Left - Plot-4
plot(data$ts,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# write the PNG (480 x 480) file
dev.copy(png, filename="plot4.png", width = 480, height = 480);
dev.off();