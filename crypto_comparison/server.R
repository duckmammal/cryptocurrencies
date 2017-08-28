#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library('shiny')
library('tidyverse') # all around good package
library('data.table') # data manipulation
library('lubridate') # date and time
library('Quandl')
library('rCharts')

bitcoin  <- Quandl("BTCE/USDBTC",collapse = "daily") %>% as.tbl()
litecoin <- Quandl("BTCE/USDLTC",collapse = "daily") %>% as.tbl()

btc <- bitcoin  %>% select(Date,Average) %>% 
    transmute(Date=Date, BTC=Average)

ltc<- litecoin %>% select(Date,Average) %>%
    transmute(Date=Date, LTC=Average)

df<- inner_join(btc, ltc, by = "Date")

df<- df[complete.cases(df),]

df<- df %>% mutate(
    BTCpct= BTC/(df$BTC %>% tail(1))-1,
    LTCpct= LTC/(df$LTC %>% tail(1))-1)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$text <- renderText(input$date)
   
  output$distPlot <- renderChart2({
      
      getdate <- which(df$Date == ymd(19700101) + days(input$date))
    
      df<- df %>% mutate(BTCpct= BTC/df$BTC[getdate]-1, LTCpct= LTC/df$LTC[getdate]-1)
          
      m1 <- mPlot(x = "Date", y = list("BTCpct", "LTCpct"), type = "Line", data = df)
      m1$set(pointSize = 0, lineWidth = 1)
      m1
    
  })
  
})
