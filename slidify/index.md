---
title       : Bitcoin Visualiser
subtitle    : 2016 - 01 - 29
author      : Alex Reijs
job         : 
framework   : landslide        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Bitcoin Visualiser

Bitcoin is a decentralised virtual currency. It has many exchange markets on which you can buy or sell BTC.

This app shows the history of some of these markets. It is meant as a proof of concept, in order to be developed further in the future.

For example, by making the data more recent and adding more advanced features, it becomes possible to do analyses that could be used to apply a smart buy/sell strategy.

Shiny app: <https://sjakil.shinyapps.io/bitcoin-visualiser>

Github: <https://github.com/sjakil/bitcoin-visualiser>

--- .class #id 

## Data Options

The app currently supports a number of market exchanges:

- BTC-e         <https://btc-e.com>
- Coinbase      <https://www.coinbase.com>
- Kraken        <https://www.kraken.com>
- LocalBitcoins <https://localbitcoins.com>
- itBit         <https://www.itbit.com>

At the moment not many currencies are supported:

- US Dollar (USD)
- Euro (EUR)

--- .class #id 

## Chart Options

A couple of options are available:

- Show grid
    - Enables display of grid along x and y axes
- Show upper/lowers bars
    - Toggles band of low/high prices around weighted value
- Zoom in on recent trades
    - Zoom in on the last 25% of the available date range

--- .class #id 

## Future additions

Features listed below are planned for the future:

- Advanced statistics
    - (Exponential) Moving Averages
    - Percentage Price Oscillator
- Candle sticks charts
- Very recent data
- Hourly data

--- .class #id 

## Data Sample and Credits

## Data Sample


```r
dataSample <- readRDS("coinbaseEUR.df")
dataSample[1:5, c(1, 3, 4, 5, 9)]
```

```
##         date low_price high_price mean_price sum_amount
## 1 2015-04-23    200.00     300.00   240.0000    0.03000
## 2 2015-04-24    220.00     220.00   220.0000    0.01000
## 3 2015-04-27    205.27     209.47   206.1360    0.22426
## 4 2015-04-28    204.48     209.53   206.4982    3.75900
## 5 2015-04-29    198.33     206.49   203.6696  261.28470
```

## Credits

For more information on bitcoin, checkout <https://bitcoin.org>

All market data is a courtesy of Bitcoin Charts (<https://bitcoincharts.com>)

Graphs are produced by dygraphs (<http://dygraphs.com>)
