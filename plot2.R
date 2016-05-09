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

## ploting the Glabal Active Power as a function of date and time
## Open png device
png(filename="plot2.png")
## Make the plot
with(dataHCG,
     plot(datetime,Global_active_power,type="l",
          xlab="",ylab="Global Active Power (kilowatts)")
)
## Close png device
dev.off()