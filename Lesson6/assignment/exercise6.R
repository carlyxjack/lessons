setwd("/home/ubuntu/userdata/Lesson6/assignment/")
library(sp)
library(rgeos)
library(rgdal)
##step 1: Unzip
unzip(zipfile='netherlands-places-shape.zip')
unzip(zipfile='netherlands-railways-shape.zip')

## step 2: Selects the "industrial railways"
dsn = file.path("data","railways.shp")
ogrListLayers(dsn) # To find out what the layers are
railways <- readOGR(dsn, layer = ogrListLayers(dsn))

## step 3: Selects the "places"
dsn = file.path("data","places.shp")
ogrListLayers(dsn) # To find out what the layers are
places <- readOGR(dsn, layer = ogrListLayers(dsn))

##step 4 select type == "industrial"

selection<-subset(railways,type=="industrial")
selection@data
selection

## RD transformation
prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
selectionRD <- spTransform(selection, prj_string_RD)
placeRD <- spTransform(places, prj_string_RD)

##buffer
buf_rails=gBuffer(selectionRD,byid=TRUE,width=1000)
plot(buf_rails,col="red")
box()

##intersection
intersection=as.data.frame(gIntersects(buf_rails, placeRD, byid=TRUE))
plot(intersection,add=TRUE,col="blue")
head(intersection)
class(intersection)


town <- subset(placeRD,intersection[,1])
findtown <-subset(placeRD,intersection[,1])
townmatch=findtown@data$name
populationmatch=findtown@data$population
townmatch
populationmatch
