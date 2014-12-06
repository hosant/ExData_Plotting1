
#PNG file where the plot is saved.
plotName <- "plot4.png"

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
df$Date.Time <- strptime(
	paste(df$Date, df$Time), 
	format = "%d/%m/%Y %H:%M:%S")

# Saves the graph in a 480x480 PNG file.
png(plotName)

#Initializes plot partition.
par(mfrow=c(2,2))

# Draws the first graph.
graph <- plot(
		df$Date.Time,
		df[[3]],
		xlab = "",
		type = "l",
		main = "",
		ylab = paste(vars[3], " (kilowatts)"),
		)

# Draws the third graph.
graph <- plot(
		df$Date.Time,
		df[[5]],
		xlab = "datetime",
		type = "l",
		main = "",
		ylab = "Voltage",
		)
		
# Makes the graph for the third plot
# with the first variable.
graph <- plot(
		df$Date.Time,
		df[[7]],
		ylim=c(0,max(df[[7]])),
		xlab = "",
		type = "l",
		ylab = "Energy sub metering",
		)

# Adds the two other variables.		
lines(df$Date.Time, df[[8]], col="red")
lines(df$Date.Time, df[[9]], col="blue")

# Adds the legend
legend("topright",
	c("Sub_metering_1","Sub_metering_2",
		"Sub_metering_3"),
	col = c("black","red","blue"),
	lty = 1
	)
	
# Draws the final plot.

graph <- plot(
		df$Date.Time,
		df[[4]],
		xlab = "datetime",
		type = "l",
		main = "",
		ylab = "Global_reactive_power",
		)
		
dev.off()