# Teste

#
# Module dependencies
#

express         = require 'express'
http            = require 'http'
path            = require 'path'
morgan          = require 'morgan'
bodyParser	    = require 'body-parser'
methodOverride	= require 'method-override'
errorhandler    = require 'errorhandler'
colors          = require 'colors'

app = module.exports = express()

#
# Configuration
#
assetsPath = path.join(__dirname, '..', '_public')

# all environments
app.use morgan 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: true)
app.use methodOverride()
app.use express.static(assetsPath)

# development only
if app.get('env') is 'development'
  app.use errorhandler()

  global.configConn =
    user: 'username',
    password: 'password',
    server: 'serverhost',
    database: 'databasename',
    port: 1433,
    options:
      encrypt: true

# production only
# if app.get('env') is 'production'
  # TODO

#
# Routes
#

# JSON API

nocache = (req, res, next) ->
  res.header 'Cache-Control', 'no-cache, no-store, must-revalidate'
  res.header 'Pragma', 'no-cache'
  res.header 'Expires', 0
  next()

api = {}

api.post = require './api/post'
app.get     '/api/posts',    nocache, api.post.posts
app.get     '/api/post/:id', nocache, api.post.post
app.post    '/api/post',     api.post.add
app.put     '/api/post/:id', api.post.edit
app.delete  '/api/post/:id', api.post.delete
app.get     '/api/*',        (req, res) -> res.status(404).end()

# serve index for all other routes
app.get '*', (req, res) -> res.sendFile "#{assetsPath}/views/index.html"

#
# Start Server
#

module.exports.start = (port) ->
  app.set 'port', port
  http.createServer(app).listen port, ->
    console.log "Yeah " + "Bitch".blue + ", server listening port #{port}\nLivereload proxying to port " + "3000".green
