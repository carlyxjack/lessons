# -*- coding: utf-8 -*-
"""
Created on Thu Jan 26 09:08:52 2017

@author: ubuntu
"""
from twython import Twython
import json
import datetime
import os
os.chdir('/home/ubuntu/userdata/lessons/python/Thursday/')

##codes to access twitter API. 
APP_KEY = "QaIaInIHbnCeI074gowK2oIFZ"
APP_SECRET = "k5FVCE1qWSdB4nAAAO8TRHUmRxNSw2k0Y0oBZFtsvhlevn4k8M"
OAUTH_TOKEN = "3634434677-O0MUF0DHupS3ttbs5JvihFsGPmkAFOAcWYwvbaN"
OAUTH_TOKEN_SECRET = "	B9CtuIBcNZBOpD2sFGdfxZrZ8rD0ryW6Iu20lbZPvx00V"

twitter=Twython(APP_KEY,APP_SECRET,OAUTH_TOKEN,OAUTH_TOKEN_SECRET)

twitter = Twython(APP_KEY, APP_SECRET, oauth_version=2)
ACCESS_TOKEN = twitter.obtain_access_token()
print ACCESS_TOKEN
twitter = Twython(APP_KEY, access_token=ACCESS_TOKEN)

 
search_results = twitter.search(q='#amsterdam',geocode=25, count=1)
#for result in search_results['statuses']:
    #print(result)
 
#parsing out 
##parsing out 
for tweet in search_results["statuses"]:
    username =  tweet['user']['screen_name']
    followers_count =  tweet['user']['followers_count']
    tweettext = tweet['text']
    tweet_text = data['text'].encode('utf-8').replace("'","''").replace(';','')
    if tweet['place'] != None:
        full_place_name = tweet['place']['full_name']
        place_type =  tweet['place']['place_type']    
    coordinates = tweet['coordinates']['coordinates']

    if coordinates != None:
        print 'oki'
        print 'the coordinates are', coordinates
        print'the latitude is', latitude
        print'the longitude is',longitude
    if not coordinates is None:
        print'no coordinates available'
        #do it yourself: enter code her to pull out coordinate     
    print username
    print followers_count
    print tweettext
    #add some some output statements that print lat lon if present
   
output_file = 'result.csv' 

target = open(output_file, 'a')
target.write(username) 
target.write('\n') 
target.write(str(followers_count))
target.write('\n') 
target.write(tweettext)
target.write('\n') 
target.close()

