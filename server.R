library(dplyr)
library(xts)
library(dygraphs)

source("data.R")

function(input, output) {
    
    output$dygraph <- renderDygraph({
        # define market
        exchangeMarket <- paste(input$market, input$currency, sep = "")
        
        # get data for market
        data <- getData(exchangeMarket)
        data <- subset(data, date >= input$dates[1] & date <= input$dates[2])

        # get a vector of unique days
        uniqueDays <- unique(data$date)
        
        # create timeline
        xts <- xts(cbind(data$low_price, data$weighted_value, data$high_price, data$sum_amount), order.by = data$date, frequency = 1)
        names(xts) <-  c("low_price", "weighted_value", "high_price", "sum_amount")
        
        # Plot with htmlwidget dygraph
        dygraph(xts, ylab= input$currency, main = paste("Market:", input$market)) %>% 
            dySeries(name = c("low_price", "weighted_value", "high_price"), label="Weighted Value", color = "Blue") %>%  
            dySeries(name = "sum_amount", label="BTC Volume", color = "Green", stepPlot = TRUE, axis = "y2",fillGraph = TRUE) %>% 
            dyRangeSelector(dateWindow = c(as.Date(ifelse(input$recentzoom, uniqueDays[round(length(uniqueDays) * 0.75)], uniqueDays[1])), last(uniqueDays))) %>%
            dyOptions(drawGrid = input$showgrid, digitsAfterDecimal = 0, labelsKMB = TRUE, titleHeight = 40)
    })
    
    output$documentation <- renderUI({
        str1 <- "<p>Bitcoin is a decentralised virtual currency. It has many exchange markets on which you can buy or sell BTC This app shows the history of some of these markets.</p>"
        str2 <- "<p>For more information on bitcoin, checkout <a target=\"_blank\" href=\"https://bitcoin.org/\">bitcoin.org</a>.</p>"
        str3 <- "<p>Using this visualiser is pretty straight forward. Select a currency, a market and optionally a date range. The chart should load pretty soon after.</p>"
        str4 <- "<p>There are some other settings available for the chart. You can optionally show a grid or zoom in on the last 25% of the available date range.</p>"
        str5 <- "<p>Courtesy of Bitcoin Charts (<a target=\"_blank\" href=\"http://bitcoincharts.com/\">bitcoincharts.com</a>)</p>"
        HTML(paste(str1, str2, str3, str4, str5, sep = ""))
    })    
    
}