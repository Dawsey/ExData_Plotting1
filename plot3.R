    #Download the data
    filename <- "Coursera_EDA_Assignment1.zip"
    
    # Checking if archieve already exists.
    if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename, method="curl")
    }  
    
    # Checking if the unzipped folder exists and unzip if it doesn't
    if (!file.exists("household_power_consumption.txt")) { 
        unzip(filename) 
    } else { 
        print("File exists")
    }

    # Import the dataset:
    library(readr)
    household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          ";", escape_double = FALSE, 
                                          col_types = cols(Date = col_date(format = "%d/%m/%Y")),
                                          trim_ws = TRUE)
    # Subset between dates
    df <- household_power_consumption[
            which(household_power_consumption$Date>="2007-02-01" & 
                    household_power_consumption$Date<="2007-02-02"),
            ]
    
    # Prepare the plot and export as png:
    with(df,{
        # Prepare png device:
        png(filename="plot3.png", 
            width=480, 
            height=480)
                # Create the plots
                plot(dateTime, Sub_metering_1, type="l", lwd=1, col="black", 
                     ylab="Energy sub metering") 
                # Add in additional variables:
                lines(dateTime,Sub_metering_2, lwd=1, col="red") 
                lines(dateTime,Sub_metering_3, lwd=1, col="blue")     
                # Add the legend:
                legend("topright", 
                       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                       lwd=c(2,2), 
                       col=c("black", "red", "blue")) #
        dev.off()
        }      
    )