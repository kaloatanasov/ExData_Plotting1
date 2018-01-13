
## Read the data table from the provided text file (the text file needs to be saved in your
## working directory, in order for the code bellow to work).

powerConsData <- read.table("household_power_consumption.txt", header = TRUE,
                            sep = ";", stringsAsFactors = FALSE, na.strings = "?")

## Check structure to find out the class of which variables needs to be changed.

str(powerConsData)

## Change the class of the Date and the Time variables with the lubridate package.

install.packages("lubridate")
library(lubridate)

powerConsData$Date <- dmy(powerConsData$Date, tz = NULL)

str(powerConsData)

powerConsData$Time <- hms(powerConsData$Time)

str(powerConsData)

## Subset the data for the required two-day period - 2007-02-01 and 2007-02-02.
## Note: We end up with a new data set, which has 2880 observations and 9 variables.

powerConsDataSub <- powerConsData[powerConsData$Date >= "2007-02-01" &
                                  powerConsData$Date <= "2007-02-02", ]

## Start plotting with the base system; instal datasets package, if not installed already.

install.packages("datasets")
library(datasets)

hist(powerConsDataSub$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power", freq = TRUE, border = "black")

## Once the plot has been figured out, open the appropriate graphics file device;
## in this case it's png.

png(filename = "Plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(powerConsDataSub$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power", freq = TRUE, border = "black")
dev.off()

## Make sure the device was closed properly with dev.off().
