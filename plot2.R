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

# Plot
plot(dataset$datetime, dataset$Global_active_power, type = 'l', 
     xlab = '', ylab = 'Global Active Power (kilowatts)')

# Saving the plot
# This will create a png image with default dimensions 480*480
dev.copy(png, 'plot2.png')
dev.off()
