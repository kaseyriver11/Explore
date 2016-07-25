
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
library(googleVis)
library(DT)
library(plotly)
library(lubridate)
# For data tables;


# Read new data and find first and last create data; 
new1 <- new
max <- max(new1$CreateDate)
min <- min(new1$CreateDate)

# Read the datasets from your machine;
adjdata <- adjdata
techdata <- techdata
adjtechfull <- adjtechfull

# List of Adjusters;
adjtech <- c(unique(adjdata$Adjuster)) #), unique(techdata$Technician))

# Selection Options;
state <- unique(new1$State)
type <- unique(new1$Type)
race <- unique(new1$Race)





