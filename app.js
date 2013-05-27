(function() {
  var app, express, http, path, routes, user;

  express = require('express');

  routes = require('./routes');

  user = require('./routes/user');

  http = require('http');

  path = require('path');

  app = express();

  app.configure(function() {
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.logger('dev'));
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(express["static"](path.join(__dirname, 'assets')));
    return this;
  });

  app.configure('development', function() {
    app.use(express.errorHandler());
    return this;
  });

  app.get('/', function(req, res) {
    return res.render("layout", {
      title: "test"
    });
  });

  module.exports = app;

}).call(this);
