prepareDataset <- function( inputFile, dateFilter ) {
## Read dataset from file named 'inputFile' from current directory
## Limit scope to only dates expressed by regex template 'dateFilter'
## Return valid filtered subset

	classes <- c( "character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" )
	dataset <- read.csv2( inputFile, na.strings = "?", dec = ".", stringsAsFactors = FALSE, colClasses = classes )
	dataset2 <- dataset [ with( dataset, grepl( dateFilter, Date ) ),]
	dataset2$Date <- as.Date( dataset2$Date, "%d/%m/%Y" )
	dataset2$Time <- strptime( dataset2$Time, "%H:%M:%S" )
	return( dataset2 )
}

### Main program for Plot1

## Prepare Plot1 dataset
data <- prepareDataset( "household_power_consumption.txt", "^([0])?[12]/([0])?2/2007" )

## switch device to PNG
png( "plot1.png", width=480, height=480 )

## Make actual plot/hist:
hist( data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power" )

## Close device - end
dev.off()
