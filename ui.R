
# Good luck!

shinyUI(fluidPage(source('external.ui/tags.R')$value, #theme = "bootstrap.css",
  #ahhhh

navbarPage("Exploring IAA Life Insurance Data", inverse=TRUE,
         
         # Panel 1
         tabPanel("New Customers",
         fluidRow(
           column(4, align="center",   
             dateRangeInput('dateRange', 'Select Date Range:', start = min, end = max,
                            format = "mm-dd-yyyy")),
           column(2, align="center",
                  selectInput("group1", "First Demographic:",
                              choices = c("Gender" = "Gender",
                                         "State"="State","Race" = "Race",
                                         "Marriage" = "Marriage",
                                         "Type of Insurance" = "Type"))),
           column(2, align="center",
                  selectInput("group2", "Second Demographic:",
                              choices = c("State"="State","Race" = "Race",
                                         "Marriage" = "Marriage","Gender" = "Gender",
                                         "Type of Insurance" = "Type")))
           ),
         
         
            column(4, div(showOutput("piechart", "Nvd3"), style="height:250px;"), 
                   showOutput("piechart2", "Nvd3")),
            column(8,
                showOutput("chart2", "Nvd3"))
         ),
         
         # Panel 2
         tabPanel("Current Customers" #,
                #    source('external.ui/...')$value
         ),
         
         tabPanel("Current Employees" #,
                  #    source('external.ui/...')$value
         )
)))
