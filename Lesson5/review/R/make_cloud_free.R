# Team Hadochi
# 13-1-2017
# Script to remove clouds from stacks

cloud2NA <- function(x, y){
  # function to set all non-0 values as NA
  x[y != 0] <- NA
  return(x)
}

make_cloud_free <- function(stack, cloud_band){
  # function to execute cloud2NA on stack
  # stack, DataFrame of multilayer image
  # cloud_band, numeric of band number of fmask
  
  
  # extract cloud mask layer from stack
  fmask <- stack[[cloud_band]]
  stack_dropped <- dropLayer(stack, cloud_band)
  
  # execute Cloud2NA
  StackCloudFree <- overlay(x = stack_dropped, y = fmask, fun = cloud2NA)
  return(StackCloudFree)
}