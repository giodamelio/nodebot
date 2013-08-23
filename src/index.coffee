request = require "request"

# Get the apps version
version = require("../package.json").version

# Startup message
console.log "Starting NodeBot version #{version} by /u/giodamelio"

# Sets some defaults
redditRequest = request.defaults
    headers:
        "user-agent": "NodeBot version #{version} by /u/giodamelio"
    jar: true

options =
    method: "POST"
    url: "http://www.reddit.com/api/login"
    qs:
        api_type: "json"
        user: require("../credentials.json").user
        passwd: require("../credentials.json").passwd

redditRequest options, (err, res, body) ->
    if err then throw err

    # Parse the json
    body = JSON.parse body

    # Get the modhash
    modhash = body.json.data.modhash
    console.log "Got modhash:", modhash

    options =
        method: "POST"
        url: "http://www.reddit.com/api/comment"
        qs:
            api_type: "json"
            # thing_id: "t1_cbtix4b"
            thing_id: "t3_1kx7z5"
            uh: modhash
            text: 
                """
                ### Testing

                Hello World
                """
    redditRequest options, (err, res, body) ->
        if err then throw err
        console.log JSON.stringify JSON.parse(body), null, 4
