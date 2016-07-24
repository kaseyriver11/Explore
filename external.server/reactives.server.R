
cleanData <- reactive({
  new1 <- subset(new1, new1$Date >= input$dateRange[[1]])
})



