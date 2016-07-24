

# New Customer Data
newData <- reactive({
    # Filter on Date;
  new1 <- subset(new1, new1$Date >= input$dateRange[[1]])
    # Filter on Selections;
  if(length(input$gender)     > 0){new1 <- subset(new1, new1$Gender %in% input$gender)}
  if(length(input$race)       > 0){new1 <- subset(new1, new1$Race %in% input$race)}
  if(length(input$state)      > 0){new1 <- subset(new1, new1$State %in% input$state)}
  if(length(input$type)       > 0){new1 <- subset(new1, new1$Type %in% input$type)}
  if(length(input$coverage)   > 0){new1 <- subset(new1, new1$Cov %in% input$coverage)}
  if(length(input$income)     > 0){new1 <- subset(new1, new1$Income2 %in% input$income)}
  
   new1
})

employeeData <- reactive({
  data <- subset(adjtechfull, adjtechfull$Adjuster == input$employee)
})

empMetrics <- reactive({ 
    data <- adjdata
    # Overall Employee Numbers
    AvgClaims <- round(mean(data$Claims),0)
    AvgRew <- sum(data$AverageReward*data$Claims)/sum(data$Claims)
    RewardP  <- sum(data$Claims_Rewarded)/sum(data$Claims)
    CPY <- mean(data$Claims/((as.numeric(data$Last_Claim)-as.numeric(data$First_Claim))/365))
    Values  <- c("Claims", "Avg_Reward", "Reward_Percent", "Claims_per_Year") 
    Company <- c(round(AvgClaims,3), round(AvgRew,3), round(RewardP,3), round(CPY,3)) 
    # Individual Employee Numbers
    data2 <- subset(data, data$Adjuster == input$employee)
    Claims <- data2$Claims
    AvgRew <- data2$AverageReward
    RewardP  <- data2$RP
    CPY <- data2$Claims/((as.numeric(data2$Last_Claim)-as.numeric(data2$First_Claim))/365)
    Employee <- c(Claims, AvgRew, RewardP, CPY)
    df <- as.data.frame(rbind(Company,Employee))
    colnames(df) <- Values
    df$Claims <- format(df$Claims, nsmall=0)
    df
}) 



# Adjuster Technician;
recentTable <- reactive({
    data <- employeeData()
    
    data <- data[order(-(as.numeric(data$Date))),]
    keep <- c("Cov_ID", "Adj_City", "Adj_State", "Date", "Type", 
              "Reward_R", "Reward_A", "Reward_R_Desc", "Exclusion")
    data <- data[keep]
    data$Date <- as.character(data$Date)
    # if(dim(data)[1] > 10){data <- data[1:10,]}
    data
})


badTable <- reactive({
    eData <- employeeData()

    df <- subset(adjtechfull, adjtechfull$PID == "NOTHING")
    for(i in 1:dim(eData)[1]){
        person <- eData$PID[i]
        Exclusion = eData$Exclusion[i]
        if(Exclusion == 0){
            data <- subset(adjtechfull, adjtechfull$PID == person)
            if(dim(data)[1] > 1){
                Ex2 <- sum(data$Exclusion)
                if(Ex2 > 0){df <- rbind(df,data)}
            }    
        }
        df
    }
    keep <- c("Cov_ID", "Adjuster", "Type", "Reward_R", "Reward_A", "Reward_R_Desc", "Exclusion")
    df <- df[keep]
    df <- df[order(substr(df$Cov_ID,1,nchar(df$Cov_ID)-1), -df$Exclusion),] 
    df
})




