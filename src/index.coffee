request = require "request"

Reddit = require "./utils/reddit"

# Get the apps version
version = require("../package.json").version

# Startup message
console.log "Starting NodeBot version #{version} by /u/giodamelio"

# New reddit instance
reddit = new Reddit "NodeBot version #{version} by /u/giodamelio",
    loglevel: 7

# Get the credentials
credentials = require "../credentials.json"

# Login
reddit.login credentials.username, credentials.password, (body) ->
    console.log "Logged in"

    # Post a comment
    comment = 
        """
        ### Testing

        Hello World
        """
    reddit.comment "t3_1kx7z5", comment, (body) ->
        for item in body.json.data.things
            console.log item.data.contentText
