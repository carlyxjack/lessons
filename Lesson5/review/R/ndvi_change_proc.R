# Team Hadochi
# 13-1-2017
# This script is to calculate the ndvi difference

ndvi_calc <- function(x, y) {
  # function to calculate NDVI
  # x, band in NIR
  # y, band in Red
  ndvi <- (x - y) / (x + y)
  return(ndvi)
}

make_ndvi <- function(stack, NIR, Red){
  # function to execute ndvi calculation
  # stack, DataFrame of multilayer image
  # NIR, numeric of band number of in NIR
  # Red, numeric of band number of in Red
  ndvi <- raster::overlay(x=stack[[NIR]], y=stack[[Red]], fun=ndvi_calc)
  return(ndvi)
}



calc_ndvi_dif <- function(ndvi_new, ndvi_old){
  # ndvi_new, rasterlayer of ndvi
  # ndvi_old, rasterlayer of ndvi
  ndvi_dif <- ndvi_new - ndvi_old
  return(ndvi_dif)
}

make_ndvi_dif <- function(ndvi_new, ndvi_old){
  # function to execute ndvi difference calculation
  # ndvi_new, rasterlayer of ndvi
  # ndvi_old, rasterlayer of ndvi
  ndvi_dif <- raster::overlay(x=ndvi_new, y=ndvi_old, fun=calc_ndvi_dif)
  return(ndvi_dif)
}
