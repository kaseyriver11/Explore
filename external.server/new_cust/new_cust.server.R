
demograph <- renderChart({
  n1 <- nPlot(Freq ~ Race, group = "Gender", data = new1, type = "multiBarChart")
  return(n1)
})



