#Promise = require 'bluebird'

#miscApi = require './miscapi'

env = process.env.NODE_ENV or 'development'
config = require('../../config')[env]

#db = require '../models'
#sql = db.sequelize

APIPATH = config.apipath

# model routes
basicmodel = require './basicmodel'
misc = require './miscstuff'
bookroutes = require './bookroutes'
        
setup = (app) ->
  app.use "#{APIPATH}/basic", basicmodel
  app.use "#{APIPATH}/misc", misc
  app.use "#{APIPATH}/booky", bookroutes
module.exports =
  setup: setup
  
