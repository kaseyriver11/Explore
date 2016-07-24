

#library(sas7bdat)
#new <- read.sas7bdat("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/new_customers.SAS7bdat")

# New Customer Data and Column Fixes;
new <- read.csv("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/CSVs_forR/newcustomers.csv",
                stringsAsFactors = FALSE)
new$CreateDate <- as.Date('1960-01-01') + as.numeric(new$Date)
new$Income2 <- ifelse(new$Income < 35000, "1", ifelse(new$Income >= 35000 & new$Income < 70000, 2,3))
new$Year <- as.numeric(format(new$CreateDate,'%Y'))



# Adjuster data and column fixes; 
adjdata <- read.csv("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/CSVs_forR/adjdata.csv",
                    stringsAsFactors = FALSE)
adjdata$First_Claim <-as.Date(adjdata$First_Claim, origin="1960-01-01")
adjdata$Last_Claim <-as.Date(adjdata$Last_Claim, origin="1960-01-01")
adjdata$diff <- (as.numeric(adjdata$Last_Claim) - as.numeric(adjdata$First_Claim))/365
adjdata$RP <- adjdata$Claims_Rewarded/adjdata$Claims
adjdata$CPY <- adjdata$Claims/((as.numeric(adjdata$Last_Claim)-as.numeric(adjdata$First_Claim))/365)


# Unused Tech data and column fixes;
techdata <- read.csv("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/CSVs_forR/techdata.csv",
                     stringsAsFactors = FALSE)
techdata$First_Claim <-as.Date(techdata$First_Claim, origin="1960-01-01")
techdata$Last_Claim <-as.Date(techdata$Last_Claim, origin="1960-01-01")


# The full adjuster and tech data; 
adjtechfull <- read.csv("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/CSVs_forR/Adjtech_full.csv",
                        stringsAsFactors = FALSE)
adjtechfull <- subset(adjtechfull, adjtechfull$Date > -100000)
adjtechfull$Date <- as.Date(adjtechfull$Date,format = "%m/%d/%y")
adjtechfull$PID <- substr(adjtechfull$Cov_ID,1,nchar(adjtechfull$Cov_ID)-1)


