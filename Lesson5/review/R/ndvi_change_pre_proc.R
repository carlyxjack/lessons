# Team Hadochi, Michiel Voermans & Jorn van der Ent
# 13 Jan 2017
# Script to perform all preprocessing steps for the exercise of lesson 5


library(raster)

source('R/make_cloud_free.R')

# List the .tif layers from the folder
LC8 <- list.files(path = '../data/LC8_2014', pattern = '^.*\\.tif$', full.names = TRUE)
LT5 <- list.files(path = '../data/LT5_1990', pattern = '^.*\\.tif$', full.names = TRUE)

# Make a stack of all the .tif files
LC8stack <- raster::stack(LC8)
LT5stack <- raster::stack(LT5)

# Plot raw stacks
plot(LC8stack, add= TRUE)
plot(LT5stack, add= TRUE)

# Make extents equal
LT5stack <- intersect(LT5stack, LC8stack)
LC8stack <- intersect(LC8stack, LT5stack)

# Plot stacks after extent is equalised
plot(LC8stack, add= TRUE)
plot(LT5stack, add= TRUE)

# Remove clouds
LC8CloudFree <- make_cloud_free(LC8stack, 1)
LT5CloudFree <- make_cloud_free(LT5stack, 1)

# Plot stacks after clouds are removed
plot(LC8CloudFree, add= TRUE)
plot(LT5CloudFree, add= TRUE)