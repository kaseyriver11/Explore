
new <- read.csv("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/CSV/new_customers.csv", stringsAsFactors = FALSE)




library(sas7bdat)
new <- read.sas7bdat("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/new_customers.SAS7bdat")
new$CreateDate <- as.Date('1960-01-01') + as.numeric(new$Date)


# Age at Purchase;
data <- ddply(new,~year,summarise,mean=mean(Age_at_purchase))
p2 <- ggplot(data, aes(x = year, y = mean)) + geom_point() +
  ggtitle("Cars")
p2 + theme_wsj()

# Count by Gender;
data <- ddply(new,~year,summarise,count=count(Gender))
p2 <- ggplot(data, aes(x = year, y = mean)) + geom_point() +
  ggtitle("Cars")
p2 + theme_wsj()

p <- ggplot(new, aes(x=Pounds))
p + geom_histogram(binwidth=2) + theme_wsj()

p <- ggplot(new, aes(x=Age_at_purchase))
p + geom_histogram(binwidth=1) + theme_wsj()


df2 <- count(new, c('State','Race'))
df2$Col1 <- df2$State
n1 <- nPlot(freq ~ Col1, group = "Race", data = df2, type = "multiBarChart")
n1


p5 <- nPlot(~ Gender, data = new, type = 'pieChart')
p5$chart(donut = TRUE)
p5

hair_eye = as.data.frame(HairEyeColor)
hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")



# Fixing adjdata;
head(adjdata)
adjdata$diff <- (as.numeric(adjdata$Last_Claim) - as.numeric(adjdata$First_Claim))/365
adjdata$RP <- adjdata$Claims_Rewarded/adjdata$Claims
adjdata$CPY <- adjdata$Claims/((as.numeric(adjdata$Last_Claim)-as.numeric(adjdata$First_Claim))/365)
adjdata <- adjdata[order(-adjdata$RP),]
adjdata[adjdata$CPY > 5.609,]

# Find percentile
perc.rank <- function(x) trunc(rank(x))/length(x)
perc.rank(adjdata$CPY)




## PLot of populations;
pop <- read.csv("C:/Users/kaseyriver11/Google Drive/IAA_Insurance/CSVs_forR/population2.csv", stringsAsFactors = FALSE)


install.packages("ggmap")
library(ggmap)

center = as.numeric(geocode("Los Angeles, CA"))
USAMap = ggmap(get_googlemap(center=center, scale=2, zoom=4), extent="normal")

USAMap +
    geom_point(aes(x=X, y=Y), data=pop, col="orange", alpha=0.4, size=pop$N_Percent*10) + 
    scale_size_continuous(range=range(pop$Population))


