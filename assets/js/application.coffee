#= require jquery-1.7.1.min.js
#= require underscore-min.js

jQuery ->
  #Home Page
  if window.location.pathname is '/'
    refresh = ->
      window.location = '/'

    socket = io.connect("/")

    # DEBUG
    window.socket = socket

  socket.on "data", (data) ->
    symbolCounts = for symbol, count of data.symbols
      val = data.symbols[ symbol] / data.total
      if isNaN val
        val = 0
      $('li[data-symbol="' + symbol + '"]').each ->
        $(this).css 'background-color', 'rgb(' + Math.round(val * 255) + ',0,0)'
    $('#last-update').text(new Date().toTimeString())