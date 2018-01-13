
## Read the data table from the provided text file (the text file needs to be saved in your
## working directory, in order for the code bellow to work).

powerConsData <- read.table("household_power_consumption.txt", header = TRUE,
                            sep = ";", stringsAsFactors = FALSE, na.strings = "?")

## Check structure to find out the class of which variables needs to be changed.

str(powerConsData)

## Combine the Date and Time variables and move the DateTime variable in the beginning
## of the data set for easier read.

powerConsData$DateTime <- paste(powerConsData$Date, powerConsData$Time)

powerConsData <- powerConsData[ , c(1, 2, 10, 3:9)]

str(powerConsData)

## Change the class of the DateTime variable to date/time with the strptime() function.

powerConsData$DateTime <- strptime(powerConsData$DateTime, format = "%d/%m/%Y %H:%M:%S")

str(powerConsData)

## Subset the data for the required two-day period - 2007-02-01 and 2007-02-02.
## Note: We end up with a new data set, which has 2881 observations and 10 variables;
## include "2007-02-03 00:00:00" since we need the Sat. illustrated on the x-axis of Plot2.

powerConsDataSub <- powerConsData[powerConsData$DateTime >= "2007-02-01 00:00:00" &
                                          powerConsData$DateTime <= "2007-02-03 00:00:00", ]

## Start plotting with the base system; instal datasets package, if not installed already.

install.packages("datasets")
library(datasets)

plot(powerConsDataSub$DateTime, powerConsDataSub$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

## Once the plot has been figured out, open the appropriate graphics file device;
## in this case it's png.

png(filename = "Plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(powerConsDataSub$DateTime, powerConsDataSub$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

## Make sure the device was closed properly with dev.off().
