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

# Checking the unique values in Global_active_power
unique(dataset$Global_active_power)

# Missing values are replaced with ?, removing those values
dataset = dataset[dataset$Global_active_power != '?', ]

# Changing to numeric
dataset$Global_active_power = as.numeric(levels(dataset$Global_active_power))[dataset$Global_active_power]

# Plot 2
hist(dataset$Global_active_power, col = 'red',
     xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power') 

# This will create a png image with default dimensions 480*480
dev.copy(png, 'plot1.png')
dev.off()
