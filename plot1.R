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

# plot 1
hist(data$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)");

# write the PNG (480 x 480) file
dev.copy(png, filename="plot1.png", width = 480, height = 480);
dev.off();