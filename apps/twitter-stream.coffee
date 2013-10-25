_ = require 'underscore'
twitter = require 'ntwitter'

twitterStream = (app) ->
  unless app.settings.watchSymbols
    app.set 'watchSymbols', ['$msft', '$intc', '$hpq', '$goog', '$nok', '$nvda', '$bac', '$orcl', '$csco', '$aapl', '$ntap', '$emc', '$t', '$ibm', '$vz', '$xom', '$cvx', '$ge', '$ko', '$jnj']

  unless app.settings.watchList
    app.set 'watchList', {
      total: 0
      symbols: {}
    }

  _.each app.settings.watchSymbols, (v) -> app.settings.watchList.symbols[v] = 0

  t = new twitter {
    consumer_key: ''          #<----- FILL ME IN
    consumer_secret: '',      #<----- FILL ME IN
    access_token_key: '',     #<----- FILL ME IN
    access_token_secret: ''   #<----- FILL ME IN
  }

  t.stream 'statuses/filter', { track: app.settings.watchSymbols }, (stream) ->
    stream.on 'data', (tweet) ->
      claimed = false

      # Make sure tweet is valid
      if tweet.text isnt undefined
        text = tweet.text.toLowerCase()

        #if mentioned, increment counter and set claimed token
        _.each app.settings.watchSymbols, (v) ->
          v = v.toLowerCase()
          if text.indexOf(v) isnt -1
            app.settings.watchList.symbols[v]++
            claimed = true

        # when something is mentioned increment total counter
        if claimed is true
          app.settings.watchList.total++
          if socketIO = app.settings.socketIO
            socketIO.sockets.emit "data", app.settings.watchList

module.exports = twitterStream
