express = require('express')
routes = require('./routes')
path = require('path')
app = express()

app.configure ->
	app.set 'views', __dirname + '/views'
	app.set 'view engine', 'jade'
	app.use express.logger 'dev'
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use(express.static(path.join(__dirname, 'assets')))
	@

app.configure 'development', ->
	app.use express.errorHandler()
	@

app.get '/', routes.other.index
app.get '/instagram', routes.instagram.all
app.get '/tag/:tag', routes.instagram.tag
app.get '/github', routes.github.all
app.get '/twitter', routes.twitter.all


module.exports = app