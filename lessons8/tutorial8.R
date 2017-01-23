##loading package and files
library(raster)
load("data/GewataB2.rda")
load("data/GewataB3.rda")
load("data/GewataB4.rda")

##checking status
cellStats(GewataB2,stat=max)
#maxValue(GewataB2) is  the same
cellStats(GewataB2,stat=mean)
#finding the max of three bands
max(c(maxValue(GewataB2),maxValue(GewataB3),maxValue(GewataB4)))
#summary(GewataB2) ##finding overview

gewata<-brick(GewataB2,GewataB3,GewataB4)
hist(gewata)
library(graphics)
par(mfrow=c(1,1)) #resetting plotting window
hist(gewata,xlim=c(0,5000),ylim=c(0,750000),breaks=seq(0,5000,by=100))
pairs(gewata) #scatterplot matrix

ndvi <- overlay(GewataB4, GewataB3, fun=function(x,y){(x-y)/(x+y)},filename="ndvi")
