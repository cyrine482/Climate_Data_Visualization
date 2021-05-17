getwd()
setwd("C:/Users/tenin/Documents/BIMS/Climate model/canada")
library(ggplot2)
library(lubridate)
library(dplyr)
library(tidyr)

library(reshape2)
library(viridisLite)
library(viridis)
library(hrbrthemes)

windowsFonts(Times=windowsFont("TT Times New Roman"))

#read the dataframe 
dfcan= read.csv(file="Final_temp_can.csv", header= TRUE, sep =";")
class(dfsen)
summarise(dfsen)
head(dfsen)
View(dfcan)
str(dfcan)

#convert date column class to date
dfcan$date= ymd(dfcan$date)
class(dfcan$date)

#ClimateCityIndia$Month <- format(ClimateCityIndia$dt,"%m")

#plot data

p <- ggplot(dfcan, aes(x=date, y=Tmean)) +
  geom_line() + 
  xlab("Date") + 
  ylab("Temperature") +
  ggtitle("temp 1901-2018 can") +
  theme_classic()
p

p + stat_smooth(
  color = "#FC4E07", fill = "#FC4E07",
  method = "loess")

# create a  month  column
dfcan$month <- month(dfcan$date)
dfcan$month= month.abb[dfcan$month] 

match(dfsen$month,month.abb)
names(dfsen)
str(dfcan)
 # create a year column 
dfcan$year= year(dfcan$date)
str(dfcan)

#month as factor

dfcan$month<- factor(dfcan$month,levels=unique(dfcan$month))
levels(dfcan$month)
dfsen$month= month.abb(dfsen$month) 
df$month = factor(df$month)

str(dfcan)


# Create a group_by object using the month column 
dfsen.month<- group_by(dfsen,month) # data_frame object month) # column name to group by
class(dfsen.month)



#plot
p <- ggplot(dfsen, aes(x=month, y=Temp)) +
  geom_point() + 
  xlab("Date") + 
  ylab("Temperature") +
  ggtitle(" monthly temp 1901-2018 sen ") +
  theme_classic()
p
# create a boxplot 

p= ggplot(dfcan, aes(x=month, y=Tmean, fill=Tmean)) +
  geom_boxplot(position=position_dodge2(preserve = "total"), notch = TRUE) +
  
  scale_fill_viridis(discrete = FALSE, alpha=0.6, name ="") +
  geom_point(color="blue", size=0.5, position=position_jitterdodge() , alpha=0.4) +

  
  theme_ipsum() +
  theme(legend.position="none",plot.title = element_text(size=11) ) +
  ggtitle("monthly Temp 1901-2018   winnipeg") +
  xlab("")
p



