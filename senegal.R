getwd()
setwd("C:/Users/tenin/Documents/BIMS/Climate model/senegal")
library(ggplot2)
library(lubridate)
library(dplyr)
library(tidyr)
install.packages("reshape2")
library(reshape2)
library(viridisLite)
library(hrbrthemes)

#read the dataframe 
dfsen= read.csv(file="final_data_temp_seng.csv", header= TRUE, sep =";")
class(dfsen)
summarise(dfsen)
head(dfsen)
View(dfsen)
str(dfsen)

#convert date column class to date
dfsen$date= ymd(dfsen$date)
class(dfsen$date)

#plot data

p <- ggplot(dfsen, aes(x=date, y=Temp)) +
  geom_line() + 
  xlab("Date") + 
  ylab("Temperature") +
  ggtitle("temp 1901-2018 sen") +
  theme_classic()
p
p + stat_smooth(
  color = "#FC4E07", fill = "#FC4E07",
  method = "loess")

# create a year column
dfsen$month <- month(dfsen$date)
dfsen$month= month.abb[dfsen$month] 
match(dfsen$month,month.abb)
names(dfsen)
str(dfsen)


#month as factor

dfsen$month<- factor(dfsen$month, ordered= FALSE)
levels(dfsen$month)
dfsen$month= month.abb[dfsen$month] 
df$month = factor(df$month)

str(dfsen)


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

p= ggplot(dfsen, aes(x=month, y=Temp, fill=Temp)) +
  geom_boxplot(notch = TRUE) +
  scale_fill_viridis(discrete = FALSE, alpha=0.6) +
  geom_jitter(color="blue", size=0.3, alpha=0.8) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("monthly Temp 1901-2018  sen") +
  xlab("")
p


#create a time serie 

temp_sen <- ts(dfsen, start=c(1901,1), end=c(2018,1),frequency=12)
View(temp_sen)
plot.ts(temp_sen, ylab="Temperature", main=" Mean Temp seng", lty=c("dotted", "solid"))
 
