## load the sp and gdal packages
library(sp)
library(rgdal)

## coordinates of a placemark in Wageningen
point1 <-cbind(5.665815,51.985168)
point2 <-cbind(5.657097,51.980263)

##Combine coordinates
matrix <-rbind(point1,point2)

## Make spatial points object
prj_string_WGS <-CRS("+proj=longlat +datum=WGS84")
mypoints <-SpatialPoints(matrix,proj4string=prj_string_WGS)

##check class
#class(mypoints)

## display data in a dataframe
mydata <-data.frame(cbind(id=c(1,2),
	      Name=c("my first point",
	      "my second point")))

##Make spatial datapoints frame
mypointsdf <-SpatialPointsDataFrame(matrix,data=mydata,proj4string=prj_string_WGS)

##check class
#class(mypointsdf)
#names(mypointsdf)
#str(mypointsdf)

##making plot
spplot(mypointsdf,zcol="Name",col.regions=c("red","blue"),
xllim=bbox(mypointsdf)[1, ]+c(-0.01,0.01),
ylim=bbox(mypointsdf)[2, ]+c(-0.01,0.01),
scales=list(draw=TRUE))

##question 2 What should be done to the following code?
spplot(mypointsdf,col.regions=c(1,2),

##making a line spatial starting from scratch:making a line
##question3 What is the difference between Line and Lines?
(simple_line <- Line(matrix))
(lines_obj <- Lines(simple_line,"1"))
(spatlines <- SpatialLines(list(lines_obj),proj4string=prj_string_WGS))
(line_data <- data.frame(Name="straight line", row.names="1"))
(mylinesdf <-SpatialLinesDataFrame(spatlines,line_data))
#class(mylinesdf)
#str(mylinesdf)
spplot(mylinesdf,col.regions="blue",
xlim=bbox(mypointsdf)[1, ]+c(-0.01,0.01),
ylim=bbox(mypointsdf)[2, ]+c(-0.01,0.01),
scales=list(draw=TRUE))

##write to KML, we assume a subdirectory data within the current working dir
#dir.create("data",showWarnings=FALSE)
writeOGR(mypointsdf,file.path("/home/ubuntu/userdata/Lesson6/","mypointsGE.kml"),
"mypointsGE",driver="KML",overwrite_layer=TRUE)
writeOGR(mylinesdf,file.path("/home/ubuntu/userdata/Lesson6/","mylinesGE.kml"),
"mylinesGE",driver="KML",overwrite_layer=TRUE)
dsn = file.path("/home/ubuntu/userdata/Lesson6/","route.kml")
ogrListLayers(dsn)
myroute <-readOGR(dsn,ogrListLayers(dsn))
proj4string(myroute) <-prj_string_WGS
#names(myroute)
myroute$Description <-NULL
mylinesdf <-rbind.SpatialLines(mylinesdf,myroute

##transformation coordinate system
## Define CRS object for RD projection
library(rgeos)
prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
mylinesRD <- spTransform(mylinesdf, prj_string_RD)
plot(mylinesRD,col=c("red","blue"))
box()

(mylinesdf$length <-gLength(mylinesRD,byid=T))
#mylinesdf@data

##polygon ## Perform the coordinate transformation from WGS84 (i.e. not a projection) to RD (projected)"
#  This step is necessary to be able to measure objectives in 2D (e.g. meters)
(mypointsRD <-spTransform(mypointsdf,prj_string_RD))
point1RD <- coordinates(mypointsRD)[1, ]
point2RD <- coordinates(mypointsRD)[2, ]
## Make circles around points, with radius equal to distance between points
## Define a series of angles going from 0 to 2pi
ang <- pi*0:200/100
circle1x <- point1RD[1] + cos(ang) * mylinesdf$length[1]
circle1y <- point1RD[2] + sin(ang) * mylinesdf$length[1]
circle2x <- point2RD[1] + cos(ang) * mylinesdf$length[1]
circle2y <- point2RD[2] + sin(ang) * mylinesdf$length[1] 
c1 <- cbind(circle1x, circle1y)
c2 <- cbind(circle2x, circle2y)
plot(c2, pch = 19, cex = 0.2, col = "red", ylim = range(circle1y, circle2y))
points(c1, pch = 19, cex = 0.2, col = "blue")
points(mypointsRD, pch = 3, col= "darkgreen")

## Iterate through some steps to create SpatialPolygonsDataFrame object
circle1 <- Polygons(list(Polygon(cbind(circle1x, circle1y))),"1")
circle2 <- Polygons(list(Polygon(cbind(circle2x, circle2y))),"2")
spcircles <- SpatialPolygons(list(circle1, circle2), proj4string=prj_string_RD)
circledat <- data.frame(mypointsRD@data, row.names=c("1", "2"))
circlesdf <- SpatialPolygonsDataFrame(spcircles, circledat)

plot(circlesdf, col = c("gray60", "gray40"))
plot(mypointsRD, add = TRUE, col="red", pch=19, cex=1.5)
plot(mylinesRD, add = TRUE, col = c("green", "yellow"), lwd=1.5)
box()


## polygon operations with rgeos(buffer,intersect,difference)
## Expand the given geometry to include the area within the specified width with specific stylingoptions
buffpoint <- gBuffer(mypointsRD[1,], width=mylinesdf$length[1], quadsegs=2)
mydiff <- gDifference(circlesdf[1,], buffpoint)

plot(circlesdf[1,], col = "red")
plot(buffpoint, add = TRUE, lty = 3, lwd = 2, col = "blue")
gArea(mydiff)
plot(mydiff, col = "red")
myintersection <- gIntersection(circlesdf[1,],buffpoint)
plot(myintersection,col="blue")
gArea(myintersection)