path = require 'path'
mpath = path.resolve __dirname, 'bapimodels'
BSapi = require('bookshelf-api')
  path: mpath
#Promise = require 'bluebird'

#miscApi = require './miscapi'

env = process.env.NODE_ENV or 'development'
config = require('../../config')[env]

APIPATH = config.apipath

# model routes
basicmodel = require './basicmodel'
misc = require './miscstuff'
bookroutes = require './bookroutes'

setup = (app) ->
  app.use "#{APIPATH}/basic", basicmodel
  app.use "#{APIPATH}/misc", misc
  app.use "#{APIPATH}/booky", bookroutes
  app.use "#{APIPATH}/bapi", BSapi
  
  
module.exports =
  setup: setup
  
