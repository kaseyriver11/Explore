
# Good luck!

shinyUI(fluidPage(source('external.ui/tags.R')$value, #theme = "bootstrap.css",
  

navbarPage("Exploring IAA Life Insurance Data", inverse=TRUE,
         
         # Panel 1
         tabPanel("New Customers",
                  
          conditionalPanel(condition = "input.selection == true",
          fluidRow(column(2,selectInput("gender", "Gender", 
                                        choices=c("Male"="male", "Female"="female"), multiple=TRUE)),
                   column(2,selectInput("race", "Race",
                                        choices=c(race), multiple=TRUE)),
                   column(2,selectInput("state", "State",
                                        choices=c(state), multiple=TRUE)),
                   column(2,selectInput("type", "Type of Insurance",
                                        choices=c(type), multiple=TRUE)),
                   column(2,selectInput("coverage", "Coverage Amount",
                                        choices=c("$50,000"= "1", "$100,000"= "2", "$150,000" = "3"), multiple=TRUE)),
                   column(2,selectInput("income", "Income Bracket", 
                                        choices=c("$0-$35,000"=1,"$35,000-$70,000"=2,"$70,000+"=3), multiple=TRUE))
                   
          )),    
          checkboxInput("selection", "Click to filter data"),
                  
                  
                  
                  
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
         
         fluidRow(column(4, textOutput("title1")),
                  column(6, textOutput("title2"))),
         
         
            column(4, div(showOutput("piechart", "Nvd3"), style="height:250px;"), 
                   showOutput("piechart2", "Nvd3")),
            column(8,
                showOutput("chart2", "Nvd3"))
         # ,
         # fluidRow(),
         # 
         # fluidRow(column(8,
         #        showOutput("line1", "Morris")))
         ),
         
         
         
         # Panel 2
         tabPanel("Current Customers" #,
                #    source('external.ui/...')$value
         ),
         
         
         
         # Panel 3
         tabPanel("Current Adjusters",
        
        fluidRow(
            column(2, align="center",   
               selectInput('employee', 'Select Employee:', choices=c("Select Employee:" = "", as.character(adjtech)), 
                           multiple=FALSE), selectize=TRUE),
            column(6, htmlOutput("text1"))
        ),
        
        fluidRow(
            column(2),
            column(8,
            tabsetPanel(
                tabPanel("Performance Metrics", align="left", tableOutput("empMetrics1")),
                tabPanel("Possible Errors", align="left", tableOutput("badTable1")),
                tabPanel("Employee Reward History", align="center", dataTableOutput("recentTable1")))
            ))
        )
        )
))





