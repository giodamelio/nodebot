request = require "request"

# Get the apps version
version = require("../package.json").version

# Startup message
console.log "Starting NodeBot version #{version} by /u/giodamelio"

options =
    method: "POST"
    url: "http://www.reddit.com/api/login"
    headers:
        "user-agent": "NodeBot version #{version} by /u/giodamelio"
    qs:
        api_type: "json"
        user: require("../credentials.json").user
        passwd: require("../credentials.json").passwd

request options, (err, res, body) ->
    if err then throw err
    console.log body