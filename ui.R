library(dygraphs)

shinyUI(fluidPage(
    
    titlePanel("Bitcoin Visualiser"),
    
    sidebarLayout(
        sidebarPanel(
            h3("Data settings"),
            selectInput("currency", label = "Currency",
                        choices = c("EUR", "USD"),
                        selected = "USD"),
            selectInput("market", label = "Market",
                        choices = c("btce", "coinbase", "kraken", "localbtc", "itbit"),
                        selected = "btce"),
            dateRangeInput("dates", start = "2012-01-01", min = "2012-01-01", max = format(Sys.Date(), format=""),label = "Date range"),
            hr(),
            h3("Chart settings"),
            checkboxInput("showgrid", label = "Show Grid", value = FALSE),
            checkboxInput("showbars", label = "Show upper/lowers bars", value = TRUE),
            checkboxInput("recentzoom", label = "Zoom in on recent trades", value = TRUE),
            hr(),
            h3("Documentation"),
            htmlOutput("documentation")
        ),
        mainPanel(
            dygraphOutput("dygraph", height = "800px")
        )
    )
))