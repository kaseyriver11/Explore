

shinyServer(function(input, output, session){
    
    ### NEW CUSTOMERS###
  output$chart2 <- renderChart2({
    validate( need(input$group1 != input$group2 , 'Please select different groups.'))
    new1 <- newData()
    
    df <- count(new1, c(input$group1, input$group2))
    df$Col1 <- df[,1]
    df$Col2 <- df[,2]
    n1 <- nPlot(freq ~ Col1, group = "Col2", data = df, type = "multiBarChart")
    n1$yAxis(tickFormat = "#! function(d) {return d} !#")
    n1$chart(color = c('#F7941E', '#6E91A3', '#608DC3', '#48626F', '#9FBE61', '#8D74AD'))
    n1$params$height <- 500
    n1$yAxis( axisLabel = "New Customers" )
    n1$chart(margin = list(left = 100))
    n1$xAxis( axisLabel = paste0(input$group1))
    n1
  })
  output$title2 <- renderText({
      a <- paste0("Comparing new customers by selected demographics. Colors represent ", input$group2, ".")
  })
   # Pie Chart;
  output$piechart <- renderChart2({
    new1 <- newData()
    a <- as.character(input$group1)
    b <- which(colnames(new1)==a)
    new1$col <- new1[,b]
    p <- nPlot(~ col, data = new1, type = 'pieChart')
    p$chart(donut = TRUE)
    p$chart(color = c('#F7941E', '#6E91A3', '#608DC3', '#48626F', '#9FBE61', '#8D74AD'))
    p$params$height <- 245
    p$params$width <- 350
    p
  })
  #Pie Chart 2; 
  output$piechart2 <- renderChart2({
    new1 <- newData()
    a <- as.character(input$group2)
    b <- which(colnames(new1)==a)
    new1$col <- new1[,b]
    p <- nPlot(~ col, data = new1, type = 'pieChart')
    p$chart(donut = TRUE)
    p$chart(color = c('#F7941E', '#6E91A3', '#608DC3', '#48626F', '#9FBE61', '#8D74AD'))
    p$params$height <- 245
    p$params$width <- 350
    p
  })
  output$title1 <- renderText({
      a <- paste0("New Customers by ", input$group1, ", followed by ", input$group2, ".")
      a
  })
  
  output$line1 <- renderChart2({
      new1 <- newData()
      new1 <- subset(new1, new1$Year < 2013)
      a <- as.data.frame(table(new1$Year))
      colnames(a) <- c("Year", "Count")
      m1 <- mPlot(x = "Year", y = c("Count"), type = "Line", data = a)
      m1$set(pointSize = 0, lineWidth = 1)
      m1
      
  })
  
  
  
    ### Adjusters and Technicians ###
  
    # Employees Recent Table
    output$recentTable1 <- renderDataTable({
        validate(need(input$employee != "", " "))
        df <- recentTable()
        datatable(df)
    })
    
    # The Employee Metric Table
    output$empMetrics1 <- renderTable({
        validate(need(input$employee != "", " "))
        df <- empMetrics()
        df
    }, row.names = FALSE)
    
    # The time an employee might have messed up 
    output$badTable1 <- renderTable({
        validate(need(input$employee != "", " "))
        df <- badTable()
        df
    }, row.names = FALSE)
    
    # The text we output;
    output$text1 <- renderUI({
        validate(need(input$employee != "", "Please select an employee."))
        df <- empMetrics()
        adata <- adjdata
        baddata <- badTable()
        perc.rank <- function(x) trunc(rank(x))/length(x)
        value  <- round(perc.rank(adjdata$CPY)[which(adjdata$Adjuster == input$employee)],2)
        value2 <- 1 - round(perc.rank(adjdata$RP)[which(adjdata$Adjuster == input$employee)],2)

        
        str1 <- paste0("Potential reward errors: ", sum(baddata$Exclusion))
        str2 <- paste0("Potential additional cost to company: ", 
                       sum(baddata$Reward_A[baddata$Adjuster == input$employee]))
        str3 <- paste0("Employee ", input$employee, " is averaging ", round(df$Claims_per_Year[2],2), " claims per year. 
                       This is in the top ", value*100, "%  of employees.")
        str4 <- paste0(input$employee, " is also rewarding claims at a rate of ", round(df$Reward_Percent[2],2), 
                        " . This is in the top ", value2*100, "% of employees.")
        
        HTML(paste(str1, str2, str3, str4, sep = '<br/>'))
    })
  
    output$trendPlot <- renderPlotly({
      # geo styling
      m <- list(
        colorbar = list(title = "Average Reward Amount"),
        size = 8, opacity = 0.8, symbol = 'circle'
      )

      g <- list(
        scope = 'usa',
        projection = list(
          type = 'conic conformal',
          rotation = list(
            lon = -100
          )
        ),
        showland = TRUE,
        landcolor = toRGB("gray95"),
        subunitcolor = toRGB("gray85"),
        countrycolor = toRGB("gray85"),
        countrywidth = 0.5,
        subunitwidth = 0.5
      )
      #
      # g <- list(
      #   scope = 'north america',
      #   showland = TRUE,
      #   landcolor = toRGB("grey83"),
      #   subunitcolor = toRGB("white"),
      #   countrycolor = toRGB("white"),
      #   showlakes = TRUE,
      #   lakecolor = toRGB("white"),
      #   showsubunits = TRUE,
      #   showcountries = TRUE,
      #   resolution = 50,
      #   projection = list(
      #     type = 'conic conformal',
      #     rotation = list(
      #       lon = -100
      #     )
      #   ),
      #   lonaxis = list(
      #     showgrid = TRUE,
      #     gridwidth = 0.5,
      #     range = c(-140, -55),
      #     dtick = 5
      #   ),
      #   lataxis = list(
      #     showgrid = TRUE,
      #     gridwidth = 0.5,
      #     range = c(20, 60),
      #     dtick = 5
      #   )
      # )
      
      plot_ly(geocode, lat = lat, lon = lon, text = hover ,size = geocode$`Number of Customers`, color = avg_reward,
              type = 'scattergeo', mode = 'markers',
              marker = m) %>%
        layout(title = 'IAA Insurance', geo = g)
    })
  
  
    ### Files for Panel 1 ###
    panel1.server.dir <- 'external.server/'
    source(paste0(panel1.server.dir, 'reactives.server.R'), local = T)
    
    ### Files for Panel 2 ###
    panel2.server.dir <- 'external.server/panel2/'
    # source(paste0(panel2.server.dir, 'panel2.server.R'),    local = T)
    
    ### Files for Panel 3 ###
    panel3.server.dir <- 'external.server/objective3/'
    # source(paste0(panel3.server.dir, 'panel3.server.R'), local = T)
})



















# OLD;

# output$chart <- renderPlot({
#   new1 <- newData()
#   if(input$demo %in% ("Age_at_purchase")){
#     data <- ddply(new1,~year,summarise,mean=mean(Age_at_purchase))}
#   if(input$demo %in% ("Gender")){
#     data <- ddply(new1,~year,summarise,mean=count(Gender))}
#   if(input$demo %in% ("inches")){
#     data <- ddply(new1,~year,summarise,mean=mean(inches))}
# 
#   p <- ggplot(data, aes(x = year, y = mean)) + geom_point() +
#     ggtitle(input$demo)
#   p <- p + geom_hline(yintercept=mean(data$mean))
#   p + theme_wsj()
# })



