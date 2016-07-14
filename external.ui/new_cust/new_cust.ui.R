

sidebarPanel(
  selectInput("demo", "Demographic:",
              choices = c("Age at Purchase" = "Age_at_purchase", "Year" = "Year", "State" = "State", 
                          "City" = "City", "Race" = "Rage", "Marriage" = "Marriage")),
  
  dateRangeInput('dateRange', 'Select Date Range:', start = min, end = max,
                 format = "mm-dd-yyyy")
)


  showOutput("demograph", "polycharts")

