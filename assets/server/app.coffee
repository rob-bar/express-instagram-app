express = require('express')
routes = require('./routes')
user = require('./routes/user')
http = require('http')
path = require('path')
app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.vhost('foo.com', express)
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use(express.static(path.join(__dirname, 'assets')))
  @

app.configure 'development', ->
  app.use express.errorHandler()
  @


app.get '/', (req,res)->
  res.send('cool')

module.exports = app