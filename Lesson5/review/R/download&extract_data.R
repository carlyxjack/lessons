# Team Hadochi, Michiel Voermans & Jorn van der Ent
# 13 Jan 2017
# This script is for obtaining all data for exercise of lesson 5

# import libraries
library(raster)

# check if folder exists
if (dir.exists(file.path('../data')) == FALSE) {
  dir.create('../data/')}

# download data
download.file('https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=1', destfile = '../data/LC8_2014.tar.gz', method = 'auto', mode = 'wb')
download.file('https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=1', destfile = '../data/LT5_1990.tar.gz', method = 'auto', mode = 'wb')

# list filenames
filenames <- list.files('../data/', pattern = glob2rx('*.tar.gz'), full.names = TRUE)

# make seperate directories for extractions if they not already exist
if (dir.exists(file.path('../data/LC8_2014')) == FALSE ){
  dir.create('../data/LC8_2014')}
if (dir.exists(file.path('../data/LT5_1990')) == FALSE ){
  dir.create('../data/LT5_1990')}


# Extract files into directories
untar(filenames[1], exdir = '../data/LC8_2014')
untar(filenames[2], exdir = '../data/LT5_1990')