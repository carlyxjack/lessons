# -*- coding: utf-8 -*-
"""
Created on Thu Jan 26 11:21:58 2017

@author: ubuntu
"""
from twython import TwythonStreamer
import string, json, pprint
import urllib
from datetime import datetime
from datetime import date
from time import *
import string, os, sys, subprocess, time
import psycopg2

os.chir('/home/ubuntu/userdata/lessons/python/Thursday/')

APP_KEY ="QaIaInIHbnCeI074gowK2oIFZ"
APP_SECRET ="k5FVCE1qWSdB4nAAAO8TRHUmRxNSw2k0Y0oBZFtsvhlevn4k8M"
OAUTH_TOKEN ="3634434677-O0MUF0DHupS3ttbs5JvihFsGPmkAFOAcWYwvbaN"
OAUTH_TOKEN_SECRET ="B9CtuIBcNZBOpD2sFGdfxZrZ8rD0ryW6Iu20lbZPvx00V"

output_file = 'result2_'+datetime.now().strftime('%Y%m%d-%H%M%S')+'.csv' 

#Class to process JSON data comming from the twitter stream API. Extract relevant fields
class MyStreamer(TwythonStreamer):
    def on_success(self, data):
         tweet_lat = 0.0
         tweet_lon = 0.0
         tweet_name = ""
         retweet_count = 0

         if 'id' in data:
               tweet_id = data['id']
         if 'text' in data:
               tweet_text = data['text'].encode('utf-8').replace("'","''").replace(';','')
         if 'coordinates' in data:    
               geo = data['coordinates']
               if not geo is None:
                    latlon = geo['coordinates']
                    tweet_lon = latlon[0]
                    tweet_lat= latlon[1]
         if 'created_at' in data:
                    dt = data['created_at']
                    tweet_datetime = datetime.strptime(dt, '%a %b %d %H:%M:%S +0000 %Y')

         if 'user' in data:
                    users = data['user']
                    tweet_name = users['screen_name']

         if 'retweet_count' in data:
                    retweet_count = data['retweet_count']
                    
         if tweet_lat != 0:
                    #some elementary output to console    
                    string_to_write = str(tweet_datetime)+", "+str(tweet_lat)+", "+str(tweet_lon)+": "+str(tweet_text)
                    print string_to_write
                    write_tweet(string_to_write)
                 
    def on_error(self, status_code, data):
         print "OOPS FOUTJE: " +str(status_code)
         self.disconnect
         
##main procedure
def main():
    try:
        stream = MyStreamer(APP_KEY, APP_SECRET,OAUTH_TOKEN, OAUTH_TOKEN_SECRET)
        print 'Connecting to twitter: will take a minute'
    except ValueError:
        print 'OOPS! that hurts, something went wrong while making connection with Twitter: '+str(ValueError)
    #global target
    
    
    # Filter based on bounding box see twitter api documentation for more info
    try:
        stream.statuses.filter(locations='3.00,50.00,7.35,53.65')
    except ValueError:
        print 'OOPS! that hurts, something went wrong while getting the stream from Twitter: '+str(ValueError)

    
def write_tweet(t):
    target = open(output_file, 'a')
    target.write(t)
    target.write('\n')
    target.close()
                

if __name__ == '__main__':
    main()
