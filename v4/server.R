#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
data("managers")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderChart2({
    
      perf <- data.frame(table.CalendarReturns(managers[, 
            c(1, 8, 9)])[, 
            13:(12 + NCOL(managers[, c(1, 8, 9)]))], stringsAsFactors = FALSE)
      
      # make rownames a column
      perf <- data.frame(rownames(perf), perf, row.names = NULL)
      # add date to column names and remove . from
      # column names to not confuse js
      colnames(perf) <- c("date", gsub(x = colnames(perf[-1]), 
                                       pattern = "[.]", replacement = ""))
      
      # build the plot
      m2 <- mPlot(x = "date", y = colnames(perf)[-1], data = perf, 
                  type = "Bar")
      # not pretty colors but an example how we can
      # specify
      m2$set(barColors = brewer.pal(10, "BrBG")[c(8, 4, 5)])
      m2$set(postUnits = "%")
      m2$set(hideHover = "auto")
      m2
    
  })
  
})
