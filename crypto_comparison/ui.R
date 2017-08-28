#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library('shiny')
library('rCharts')


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Bitcoin vs Litecoin as Percents"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       # Calendar with a input for comparison date
       dateInput("date", "Date:", value = "2017-07-20"),
       
       width = 3
    ),
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
        
        
        textOutput("text"),
        
       showOutput("distPlot", lib = "morris")
    )
  )
))
