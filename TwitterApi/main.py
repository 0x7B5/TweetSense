#!/usr/bin/env python3
from flask import Flask, jsonify
from twitterscraper import query_tweets_from_user, query_tweets
from datetime import datetime

app = Flask(__name__, static_url_path="")
@app.route('/tweets/<username>', methods=['GET'])
def getTweets(username):
    list_of_tweets = query_tweets_from_user(username, 100)
    tweets = [ ]
    #print the retrieved tweets to the screen:
    for tweet in list_of_tweets:
        tweets.append({
                        "Date": tweet.timestamp,
                        "Text": tweet.text
                      })
                      
    return jsonify(tweets)
    
@app.route('/deepTweets/<username>', methods=['GET'])
def getDeepTweets(username):
    list_of_tweets = query_tweets_from_user(username, None)
    tweets = [ ]
    #print the retrieved tweets to the screen:
    for tweet in list_of_tweets:
        tweets.append({
                        "Date": tweet.timestamp,
                        "Text": tweet.text
                      })
                      
    return jsonify(tweets)

@app.route('/topic/<topic>', methods=['GET'])
def getTopicTweets(topic):
    list_of_tweets = query_tweets(topic,poolsize=15)
    tweets = [ ]
    #print the retrieved tweets to the screen:
    for tweet in list_of_tweets:
        tweets.append({
                        "Date": tweet.timestamp,
                        "Text": tweet.text
                      })
                      
    return jsonify(tweets)

if __name__ == '__main__':
    app.run(debug=False)
    
