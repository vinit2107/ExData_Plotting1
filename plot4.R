library(stringr)
library(lubridate)

# Reading the dataset
dataset <- read.table('household_power_consumption.txt', sep = ';', header = T)

# Validating the dimensions of the data frame
dim(dataset)

# Column of the dataset
names(dataset)

# Filtering the dataset for required dates
dataset = dataset[dmy(dataset$Date) == as.Date('2007-02-01') | 
                          dmy(dataset$Date) == as.Date('2007-02-02'), ]

# Adding a column to the dataset to contain the date time combination
datetime = str_c(dmy(dataset$Date), dataset$Time, sep = ' ')
dataset$datetime = strptime(datetime, format = '%Y-%m-%d %H:%M:%S')

# Missing values are replaced with ?, removing those values
dataset = dataset[dataset$Global_active_power != '?', ]

# Changing to numeric
dataset$Global_active_power = as.numeric(levels(dataset$Global_active_power))[dataset$Global_active_power]

dataset$Sub_metering_1 = as.numeric(levels(dataset$Sub_metering_1))[dataset$Sub_metering_1]
dataset$Sub_metering_2 = as.numeric(levels(dataset$Sub_metering_2))[dataset$Sub_metering_2]

par(mfrow = c(2, 2), mar = c(4, 4, 4, 4))
# Plots
# Plot 1
plot(dataset$datetime, dataset$Global_active_power, type = 'l', ylab= 'Global Active Power', xlab = '')
# Plot 2
plot(dataset$datetime, dataset$Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime')
# Plot 3
plot(dataset$datetime, dataset$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(dataset$datetime, dataset$Sub_metering_2, col = 'red')
lines(dataset$datetime, dataset$Sub_metering_3, col = 'blue')
legend('topright', 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = rep(1, 3), lwd = 2, cex = 0.5,
       bty = 'n', y.intersp = 0.1, text.width = 10^4.7)
# Plot 4
plot(dataset$datetime, dataset$Global_reactive_power, type= 'l', xlab='datetime', ylab='Global_reactive_time')

# Saving the plot
dev.copy(png, 'plot4.png')
dev.off()
