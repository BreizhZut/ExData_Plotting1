## Introduction

This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. In particular, we will be using the "Individual household
electric power consumption Data Set" which I have made available on
the course web site:


* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

* <b>Description</b>: Measurements of electric power consumption in
one household with a one-minute sampling rate over a period of almost
4 years. Different electrical quantities and some sub-metering values
are available.


The following descriptions of the 9 variables in the dataset are taken
from
the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
web site</a>:

<ol>
<li><b>Date</b>: Date in format d/m/yyyy </li>
<li><b>Time</b>: time in format hh:mm:ss </li>
<li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
<li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
<li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
<li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
<li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
<li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
<li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
</ol>

## Repository edited content

On top of editing this README, this repository contains the figures :

* `plot1.png` Distribution of global Active power for the dates 2007-02-01 and 2007-02-02
* `plot2.png` Global Active power as a function of time for the dates 2007-02-01 and 2007-02-02
* `plot3.png` Energy sub metering as a function of time for the dates 2007-02-01 and 2007-02-02
* `plot4.png` For the dates 2007-02-01 and 2007-02-02 are shown:
	* *top-left*: Global Active power as a function of time
	*  *top-right*: Voltage as a function of time 
	*  *bottom-left*: Energy sub metering as a function of time 
	*  *bottom-rigth*: Global\_reactive\_power as a function of time

Additionally, the following R script necessary to generate the figures have been added.

* `getHCG.R` reads a subset of the data as 'data.frame': 'dataHCG' (
	* useful to test the plotting from console
	* additional column `datetime` object `time`, combining columns `Date` and `Time` 
* `plot1.R` reads a subset of the data, creates `plot1.png`
* `plot2.R` reads a subset of the data, creates `plot2.png`
* `plot3.R` reads a subset of the data, creates `plot3.png`
* `plot4.R` reads a subset of the data, creates `plot4.png`

These scripts call librairies `lubridate` and `dplyr`. The data file "household_power_consumption.txt" should be located in the working directory, with the scripts.


## Loading the data





When loading the dataset into R, please consider the following:

* The dataset has 2,075,259 rows and 9 columns. 
The full dataset should require about 144.5 Mb from a file of 127Mb.

* We will only be using data from the dates 2007-02-01 and
2007-02-02. One alternative is to read the data from just those dates
rather than reading in the entire dataset and subsetting to those
dates. To accomplish the latter we prepare our selection the following way

```{r}
## Read all the file
> fulldata <-read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE)
## Use grep to find the rows with dates 2007-02-01 and
2007-02-02
> rowselect <- grep("^[12]/2/2007",fulldata$Date)
> length(rowselect) == (max(rowselect)-min(rowselect)+1)
[1] TRUE
# Print the number of lines to skip and the number of rows to read
> c(min(rowselect)-1,length(rowselect))
[1] 66636  2880
# We can now read the data this way
> selecteddata <- read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,skip=66636,nrows=2880)
# Notes we don't get the columns names that way. Meaning we will need to get the header in a separate reading.
```

* You may find it useful to convert the Date and Time variables to
Date/Time classes in R using the `strptime()` and `as.Date()`
functions.

* Note that in this dataset missing values are coded as `?`. Meaning we need to use na.strings="?", however I didn't find any in the file. Also note that values are separated by ";", so use sep =";". Since the column names are indicated in the file use header=TRUE.


## Making Plots

Our overall goal here is simply to examine how household energy usage
varies over a 2-day period in February, 2007. Your task is to
reconstruct the following plots below, all of which were constructed
using the base plotting system.

First you will need to fork and clone the following GitHub repository:
[https://github.com/rdpeng/ExData_Plotting1](https://github.com/rdpeng/ExData_Plotting1)


For each plot you should

* Construct the plot and save it to a PNG file with a width of 480
pixels and a height of 480 pixels. Note: that is the default size with ```png()```

* Name each of the plot files as `plot1.png`, `plot2.png`, etc.

* Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that
constructs the corresponding plot, i.e. code in `plot1.R` constructs
the `plot1.png` plot. Your code file **should include code for reading
the data** so that the plot can be fully reproduced. You should also
include the code that creates the PNG file.

* Add the PNG file and R code file to your git repository

When you are finished with the assignment, push your git repository to
GitHub so that the GitHub version of your repository is up to
date. There should be four PNG files and four R code files.


The four plots that you will need to construct are shown below. 


### Plot 1


![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


### Plot 2

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


### Plot 3

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


### Plot 4

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

