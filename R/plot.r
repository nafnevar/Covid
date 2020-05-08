require(ggplot2)

dir <- getwd()
setwd(dir)

source('getdata.R')
data <- getData()

data <- subset(data, subset = PopTotal > 60000000 & PopTotal < 350000000 )

png(filename="Plot/plot.png", width=480, height=480)

ggplot(data = data, aes(x = Date, y = Death.Rate)) +
    geom_line(aes(x = Date, y = Death.Rate, group = Entity, colour = Entity)) +
  labs(x = "Date",
    y = "Per Capita Death Rate",
    title = "Per Capita Death Rate",
    subtitle = "")

garbage <- dev.off()
q("no")


require(ggplot2)

dir <- getwd()
setwd(dir)

source('getdata.R')
data <- getData()

data <- subset(data, subset = PopTotal > 60000000 & PopTotal < 350000000 )

png(filename="Plot/plot.png", width=480, height=480)



garbage <- dev.off()
q("no")

