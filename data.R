library(dplyr)
library(xts)
library(dygraphs)

getDaily <- function(data) {
    by_date <- group_by(data, date)
    daily <- summarise(by_date,count = n(),
                       low_price <- min(price, na.rm = TRUE),
                       high_price <- max(price, na.rm = TRUE),
                       mean_price <- mean(price, na.rm = TRUE),
                       sum_value <- sum(value, na.rm = TRUE),
                       mean_value <- mean(value, na.rm = TRUE),
                       mean_amount <- mean(amount, na.rm = TRUE),
                       sum_amount <- sum(amount, na.rm = TRUE))
    
    names(daily) <- c("date", "count", "low_price", "high_price", "mean_price", "sum_value", "mean_value", "mean_amount", "sum_amount")
    daily <- mutate(daily, weighted_value = sum_value / sum_amount)
    daily
}

getData <- function (exchangeMarket) {
    
    if (!file.exists("data"))
        dir.create("data")
    
    bitcoinFile <- paste(exchangeMarket, ".csv.gz", sep = "")
    sourceFile <- file.path("http://api.bitcoincharts.com/v1/csv", bitcoinFile)
    destFile <- paste("data/", bitcoinFile, sep = "")
    dfName <- paste("data/", exchangeMarket, ".df", sep = "")
    if (!file.exists(dfName)) {
        
        download.file(sourceFile, destfile = destFile)
        
        # Uncompress .gz file and read into a data frame
        data <- read.csv(gzfile(destFile), header=FALSE)    
        names(data) <- c("unixtime","price","amount")
        data$date <- as.Date(as.POSIXct(data$unixtime, origin="1970-01-01"))
        data <- mutate(data,value = price * amount)
        data <- select(data, -unixtime)
        
        data <- getDaily(data)
        
        file.remove(destFile)
        
        saveRDS(data, file = dfName)

    }
    else
        data <- readRDS(data, file = dfName)
    
    data
}