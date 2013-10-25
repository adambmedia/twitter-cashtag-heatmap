
/**
 * Module dependencies.
 */

require('coffee-script');

var express = require('express');
var http = require('http');
var path = require('path');

var app = module.exports = express();

// all environments
require('./apps/twitter-stream')(app);

app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(require('connect-assets')());
app.use(app.router);
app.use(require('stylus').middleware(__dirname + '/public'));
app.use(express.static(path.join(__dirname, 'public')));

// Routes
require('./apps/routes')(app);

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

var server = http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});

//socket-io after server connection
require('./apps/socket-io')(server, app);