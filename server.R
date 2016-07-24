

shinyServer(function(input, output, session){
    
    ### Intro ###
  
  output$chart <- renderPlot({
    new1 <- cleanData()
    if(input$demo %in% ("Age_at_purchase")){
      data <- ddply(new1,~year,summarise,mean=mean(Age_at_purchase))}
    if(input$demo %in% ("Gender")){
      data <- ddply(new1,~year,summarise,mean=count(Gender))}
    if(input$demo %in% ("inches")){
      data <- ddply(new1,~year,summarise,mean=mean(inches))}

    p <- ggplot(data, aes(x = year, y = mean)) + geom_point() +
      ggtitle(input$demo)
    p <- p + geom_hline(yintercept=mean(data$mean))
    p + theme_wsj()
  })
  
  
  output$chart2 <- renderChart2({
    validate( need(input$group1 != input$group2 , 'Please select different groups.'))
    new1 <- cleanData()
    
    df <- count(new1, c(input$group1, input$group2))
    df$Col1 <- df[,1]
    df$Col2 <- df[,2]
    n1 <- nPlot(freq ~ Col1, group = "Col2", data = df, type = "multiBarChart")
    n1$yAxis(tickFormat = "#! function(d) {return d} !#")
    n1$chart(color = c('#F7941E', '#6E91A3', '#608DC3', '#48626F', '#9FBE61', '#8D74AD'))
    n1$params$height <- 500
    n1
  })

  # Pie Chart;
  output$piechart <- renderChart2({
    new1 <- cleanData()
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
  
  output$piechart2 <- renderChart2({
    new1 <- cleanData()
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
  
  
  
  
  
  
    ### Files for Panel 1 ###
    panel1.server.dir <- 'external.server/'
    source(paste0(panel1.server.dir, 'reactives.server.R'),            local = T)
    
    ### Files for Panel 2 ###
    panel2.server.dir <- 'external.server/panel2/'
    # source(paste0(panel2.server.dir, 'panel2.server.R'),    local = T)
    
    ### Files for Panel 3 ###
    panel3.server.dir <- 'external.server/objective3/'
    # source(paste0(panel3.server.dir, 'panel3.server.R'), local = T)
})





