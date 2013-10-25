Refactor of thedillonb's Node + Twitter Streaming API (in coffeescript)
==========================================================

I was looking at Dillon's Node + Twitter Streaming API code at the same time as Peepcode's Full Stack Node.js screencast.

I refactored dillon's demo in the peepcode cast's style, minus tests and a bunch of other things to get just the most basic pattern.  The result is more extensible for modular future application development than putting everything in app.js

https://github.com/thedillonb/twitter-cashtag-heatmap

http://www.dillonbuchanan.com/programming/node-js-twitter-streaming-api-socket-io-twitter-cashtag-heatmap/

https://peepcode.com/products/full-stack-nodejs-i

Some Different Things
==========================================================
- installed, required coffeescript
- left server creation as it is in the express 3.4.0
- installed node-dev and executable script, ./node_modules/.bin/node-dev app.js restarting server on file saves (/bin/devserver must be executable)
- created apps/routes.coffee to handle only route
- configured socketio in separate file (may need sudo to start if you get listen EACCES error)
- put twitter in its own file, placing watchList and watchSymbols on app.settings (although there are better ways to do this)
- client side gets a complete coffeescript treatment (assets/js/application.coffee), tied together by connect-assets (back in app.js) to serve static javascript
- as in dillonb's tut, you'll need to enter your own twitter authentication info

Now, if you want to extend towards user authentication and something like, adding and deleting the twitter watch items from a database linked to the current user, as in the Peepcode tut, things are architected more similarly.

To Run Project
============================================================
- clone this repo
- npm install to get dependencies
- get your twitter credentials and enter them into apps/twitter-stream.coffee
- run ./bin/devserver (should be executable and run as admin)

Screenshot
=======================

![Screenshot](https://raw.github.com/thedillonb/twitter-cashtag-heatmap/master/screenshot.png)
