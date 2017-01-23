
try:
    from osgeo import ogr
except:
    import ogr
wkt="POINT(173914.00 441864.00)"
pt=ogr.CreateGeometryFromWkt(wkt)
print(pt)

from osgeo import osr
spatialRef=osr.SpatialReference()
spatialRef.ImportFromEPSG(4326)

#all steps needed to create a shapefile
#loading the modules
from osgeo import ogr
from osgeo import osr
import os
#setting the working directory
os.chdir('/home/ubuntu/userdata/lessons/python/Monday/')
driverName="ESRI Shapefile"
drv=ogr.GetDriverByName(driverName)
if drv is None:
    print "%s driver not available.\n" % driverName
else:
    print "%s driver IS available.\n" % driverName
fn="points.shp"
layername="anewlayer"
#create shapefiie
ds=drv.CreateDataSource(fn)
print ds.GetRefCount()
#set spatial reference
spatialReference=osr.SpatialReference()
spatialReference.ImportFromEPSG(4326)
#Create layer
layer=ds.CreateLayer(layername,spatialReference,ogr.wkbPoint)
print(layer.GetExtent())
#create point
point1=ogr.Geometry(ogr.wkbPoint)
point2=ogr.Geometry(ogr.wkbPoint)
#Setpoints
point1.SetPoint(0,4.897070,52.377956)
point2.SetPoint(0,5.104480,52.092876)
#other format:KML
print "KML file export"
print point2.ExportToKML()
##buffering
buffer=point2.Buffer(1,1)
print buffer.Intersect(point1)
#other format:GML
buffer.ExportToGML()
#defining Feature
layerDefinition=layer.GetLayerDefn()
feature1=ogr.Feature(layerDefinition)
feature2=ogr.Feature(layerDefinition)
#adding points to the feature
feature1.SetGeometry(point1)
feature2.SetGeometry(point2)
#store feature in a layer
layer.CreateFeature(feature1)
layer.CreateFeature(feature2)
print "The new extent"
print layer.GetExtent()
ds.Destroy()
