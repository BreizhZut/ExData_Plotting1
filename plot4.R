## We need package lubridate to convert character into time
library(lubridate)
library(dplyr)

## write the file to read into a variable
fileHCG <- "household_power_consumption.txt"
## test for existance
if(!file.exists(fileHCG)){
    stop(paste("File ",fileHCG,"is not found in working directory"))
}

## Let's read the header first
headHCG <- read.table(fileHCG,header=TRUE,sep=";",nrows=1)

## From previous test (check README.md for details) we know the
## they are 2880 rows with dates 2007-02-01 and 2007-02-02 (as d/m/yyyy)
## they were written in the file in sequence starting at row 66637
dataHCG <- read.table(fileHCG,header=TRUE,sep=";",skip=66636,nrows=2880,col.names = names(headHCG))

## combine date and time into a new data.frame of class time
datetime <- data.frame(datetime=dmy_hms(paste(dataHCG$Date,dataHCG$Time)))
## Add datetime to the orignal data.frame as the first column
dataHCG <- tbl_df(bind_cols(datetime,dataHCG))
## Clean up temporary variables
rm(headHCG)
rm(datetime)


## Open png device
png(filename="plot4.png")
## set multiplot
par(mfcol=c(2,2))

## ploting of the Global Active Power as a function of date and time
with(dataHCG,
     plot(datetime,Global_active_power,type="l",
          xlab="",ylab="Global Active Power (kilowatts)")
)
## Plot Energy sub metering as a function of time
## Initialise plot with Sub_metering_1
with(dataHCG,
     plot(datetime,Sub_metering_1,type="l",
          xlab="",ylab ="Energy sub metering"
     )
)
## Add Sub_metering_2 in red
with(dataHCG,
     points(datetime,Sub_metering_2,
            type="l",col="red"
     )
)
## Add Sub_metering_3 in blue
with(dataHCG,
     points(datetime,Sub_metering_3,
            type="l",col="blue"
     )
)
## Add legend
## Since I don't feel like type I use the grep command to generate the labels
legend("topright",
       legend=grep("Sub_metering",names(dataHCG),value = TRUE),
       col=c("black","red","blue"),lty=c(1,1,1)
)

## It seem that the last two plot are to be quick and dirty, with no label editing

## plot Voltage as a function of time
with(dataHCG,
     plot(datetime,Voltage,
          type="l"
     )
)

## plot Global_reactive_power as a function of time
with(dataHCG,
     plot(datetime,Global_reactive_power,
          type="l"
     )
)

## Close png device
dev.off()
## get back to the normal setting
par(mfcol=c(1,1))
