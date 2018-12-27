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
    
    library(readr)
    
    household_power_consumption <- read_delim("household_power_consumption.txt", 
                                              ";", escape_double = FALSE, 
                                              col_types = cols(Date = col_date(format = "%d/%m/%Y")),
                                              trim_ws = TRUE)
    
    df <- household_power_consumption[which(household_power_consumption$Date>="2007-02-01" & 
                                                household_power_consumption$Date<="2007-02-02"),]
    df$dateTime <- as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")
    
    png(filename="plot2.png", 
        width=480, 
        height=480)
    plot(Global_active_power~dateTime, data=df, 
         type="l",
         ylab = "Global Active Power (kilowatts)",
         xlab= "") 
    dev.off()