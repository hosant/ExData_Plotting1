
plotName <- "plot1.png"

# Names of the Variables in the data.
vars <- c("Date", "Time", "Global Active Power",
	"Global Reactive Power", "Voltage",
	"Global Intensity", "Sub Metering 1",
	"Sub Metering 2", "Sub Metering 3")

# Reads the data into a data frame.
fileName = "household_power_consumption.txt"
colClass <- c("character","character", 
		rep("double", times = 7)
		)

df <- read.csv(fileName, 
	sep=";", header = FALSE,
	colClasses = colClass,
	na.strings = "?", skip = 66637,
	nrows = 2880, col.names = vars
	)
	
# Casts the Date and Time columns
# to a single column.
df$Date.Time <- strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
# Saves the graph in a 480x480 PNG file.
png(plotName)

# Makes the graph.
graph <- hist(df[[3]], col = c("red"),
	main = "Global Active Power",
	xlab = paste(vars[3], " (kilowatts)")
	)

dev.off()