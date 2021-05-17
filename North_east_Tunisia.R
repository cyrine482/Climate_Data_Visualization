library(ggplot2)
library(lubridate)
library(dplyr)
library(gridExtra) # tile several plots next to each other
library(scales)
library(hablar)
library(tidyverse)
library(hrbrthemes)
library(viridis)
getwd()
setwd("C:/Users/tenin/Documents/BIMS/Climate model/Tunis")
df= read.csv(file="Data_temp_tunisia.csv", header= TRUE, sep=";")
head(df)
str(df)
summarise(df)
df$date= ymd(df$date)
p <- ggplot(df, aes(x=date, y=Mtemp)) +
  geom_point() + 
  xlab("Date") + 
  ylab("Temperature") +
  ggtitle(" monthly near surface temp  Tunis 1901-2018") 
p
p + stat_smooth(
  color = "#FC4E07", fill = "#FC4E07",
  method = "loess")

# create a year column
df$month <- month(df$date)
names(df)
str(df)

# Create a group_by object using the month column 
df.month<- group_by(df,month) # data_frame object month) # column name to group by
class(df.month)

p <- ggplot(df, aes(x=month, y=Mtemp)) +
  geom_point() + 
  xlab("Date") + 
  ylab("Temperature") +
  ggtitle(" monthly temp 1901-2018") +
  theme_classic()
p
df$month = factor(df$month)
str(df)
levels(df$month)
p= ggplot(df, aes(x=month, y=Mtemp, fill=Mtemp)) +
  geom_boxplot(notch = TRUE) +
  scale_fill_viridis(discrete = FALSE, alpha=0.6) +
  geom_jitter(color="blue", size=0.4, alpha=0.9) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("monthly Temp 1901-2018 tunisia") +
  xlab("")
p

# Boxplot basic

p= ggplot(df,aes(x=month, y=Mtemp, fill= month)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6, option="A") +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("Basic boxplot") +
  xlab("")
p

myts <- ts(df, start=c(1901,1 ), end=c(2018, 12), frequency=12)
plot(myts)
main <- " Mean Temp in Tunis"
lty <- c("dotted", "solid")
