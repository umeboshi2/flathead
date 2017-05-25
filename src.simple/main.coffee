os = require 'os'
path = require 'path'
http = require 'http'

express = require 'express'
favicon = require 'serve-favicon'
knex = require 'knex'

# Set the default environment to be `development`
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

# require and set config as a global
# before requiring other modules that
# depend on the config.
env = process.env.NODE_ENV or 'development'
config = require('../config')[env]
#global.window = global
#window.AppConfig = config
global.AppRootPath = path.resolve path.join __dirname, '..'
#console.log "AppRootPath", AppRootPath

set_clientjs_route = require './clientjs'

Middleware = require './middleware'
#UserAuth = require './userauth'
pages = require './pages'

webpackManifest = require '../build/manifest.json'

#eprouter = require './endpoints'

PORT = process.env.NODE_PORT or 8081
HOST = process.env.NODE_IP or 'localhost'
#HOST = process.env.NODE_IP or '0.0.0.0'

# create express app
app = express()
app.use favicon path.join __dirname, '../assets/favicon.ico'

{ knex
  bookshelf
  models } = require './kmodels'

app.locals.config = config


Middleware.setup app
  
  
# health url required for openshift
app.get '/health', (req, res, next) ->
  res.end()

app.use '/assets', express.static(path.join __dirname, '../assets')
set_clientjs_route app
  

# serve thumbnails
if process.env.NODE_ENV == 'development'
  thumbsdir = path.join __dirname, '../thumbs'
else
  thumbsdir = "#{process.env.OPENSHIFT_DATA_DIR}thumbs"
app.use '/thumbs', express.static(thumbsdir)
  
app.get '/', pages.make_page 'index'


check_for_admin_and_start = ->
  check_for_admin_user app, (count) ->
    console.log "There are #{count} users."
    if not count
      console.log "admin account created."
    server.listen PORT, HOST, ->
      console.log serving_msg
  
server = http.createServer app
serving_msg = "#{config.brand} server running on #{HOST}:#{PORT}."
server.listen PORT, HOST, ->
  console.log serving_msg

module.exports =
  app: app
  
