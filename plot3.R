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

# Plot
par(mfrow = c(1, 1), mar = c(4, 4, 4, 4))
plot(dataset$datetime, dataset$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(dataset$datetime, dataset$Sub_metering_2, col = 'red')
lines(dataset$datetime, dataset$Sub_metering_3, col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = c(1, 1, 1), cex = 0.75, y.intersp = 0.2,
       x.intersp = 0.2, ncol = 1, horiz = FALSE, text.width = 10^4.5)

# Saving the plot
dev.copy(png, 'plot3.png')
dev.off()
