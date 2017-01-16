#!/bin/R
setwd("/home/ubuntu/userdata/data/")
download.file(url = 'https://raw.githubusercontent.com/GeoScripting-WUR/IntroToRaster/gh-pages/data/gewata.zip', destfile = 'gewata.zip', method = 'auto')

unzip('gewata.zip')