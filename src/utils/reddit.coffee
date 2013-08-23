request = require "request"
Caterpillar = require("caterpillar").Logger

module.exports = class reddit
    constructor: (@userAgent, @options) ->
        # Set some defaults for future requests
        @redditRequest = request.defaults
            headers:
                "user-agent": @userAgent
            jar: true

        # Set the log level
        if @options
            @logger = new Caterpillar({ level: @options.loglevel })
        else
            @logger = new Caterpillar()

    login: (username, password, callback) ->
        options =
            method: "POST"
            url: "http://www.reddit.com/api/login"
            qs:
                api_type: "json"
                user: username
                passwd: password
        @redditRequest options , (err, res, body) =>
            if err then throw err

            # Parse the body
            body = JSON.parse body

            # Get the modhash
            @modhash = body.json.data.modhash
            @logger.log @modhash

            # Callback
            callback body, res

    comment: (thing_id, text, callback) ->
        options =
            method: "POST"
            url: "http://www.reddit.com/api/comment"
            qs:
                api_type: "json"
                thing_id: thing_id
                uh: @modhash
                text: text
        @redditRequest options, (err, res, body) ->
            if err then throw err
            callback JSON.parse(body), res
