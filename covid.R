dir <- getwd()
setwd(dir)

# https://ourworldindata.org/grapher/total-deaths-and-cases-covid-19
covid_data <- read.csv("total-deaths-and-cases-covid-19.csv",header = TRUE)

#class(covid_data$Date)
covid_data$Date <- as.Date(covid_data$Date,"%b %d, %Y")

#create a dataframe of a subset of the data for April 19
df <- subset(covid_data, Date > as.Date("2020-04-18"))

#Fix discrenpency in how USA is labeled 
df$Entity <- as.character(df$Entity)
df$Entity[df$Code == "USA"]  <- "United States of America" 

#https://population.un.org/wpp/Download/Standard/CSV/
population_data <- read.csv("WPP2019_TotalPopulationBySex.csv")

#create a dataframe of a subset of population data with hi variant and time 2020
df2 <- subset(population_data, subset = (Variant == "High" & Time == 2020))

#convert pop total to actaul number x 1000 
df2$PopTotal  <- df2$PopTotal * 1000

#create a dataframe with merged data from the above 2 files 
df3 <- merge(df, df2, by.x=c("Entity"), by.y=c("Location"))

#create a dataframe of a subset of only the columns of data we want
df4 <- df3[, c("Entity","Total.confirmed.deaths..deaths.","Total.confirmed.cases..cases.","PopTotal")]

#add our calculations to that dataframe
df4$PerCapita.Death <-  df4$Total.confirmed.deaths..deaths. / df4$PopTotal
df4$PerCapita.Infection <-  df4$Total.confirmed.cases..cases. / df4$PopTotal
df4$Death.Rate <-   df4$Total.confirmed.deaths..deaths. / df4$Total.confirmed.cases..cases. 

#save output as csv
write.csv(df4, file="output.csv")
