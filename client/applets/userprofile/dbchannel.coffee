$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

{ User
  CurrentUser } = require 'tbirds/users'
  
MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'userprofile'


AppChannel.reply 'update-user-config', ->
  console.log 'update-user-config called'
  

    
module.exports = {}
