
# Check if we have the packages needed!
need_packages <- c("shiny", "rCharts")
new.packages <- need_packages[!(need_packages %in% installed.packages()[,"Package"])]
# If we need any, install them 
if(length(new.packages)) install.packages(new.packages)

#
library(shiny)
library(tm)
library(rCharts)
library(ggplot2)
library(plyr)


new1 <- new
max <- max(new1$CreateDate)
min <- min(new1$CreateDate)

