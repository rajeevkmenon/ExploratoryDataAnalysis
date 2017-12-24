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

par(mfrow=c(1,1))

# PLOT 3
# merge Date and Time to create a new TimeStamp column
data$ts <- paste(data$Date, data$Time, sep=" ")

# get the data type converted to TimeStamp
data$ts <- as.POSIXct(data$ts, "%Y-%m-%d %H:%M:%S", tz="EST")

# plot the first line for sub-metering 1 - in black
plot(data$ts,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")


# second line for sub-metering 2 - in Red
lines(data$ts,data$Sub_metering_2,col="red")

# third line for sub-metering 3 - in Blue
lines(data$ts,data$Sub_metering_3,col="blue")

# create a legend at the top-right corner
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

# write the PNG (480 x 480) file
dev.copy(png, filename="plot3.png", width = 480, height = 480);
dev.off();