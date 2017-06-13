Backbone = require 'backbone'

MainChannel = Backbone.Radio.channel 'global'

make_auth_header = ->
  # retrieve from local storage on each request
  # to ensure current token
  #s = get_blog_session().authenticated
  #console.log 'get_blog_session', s
  #"#{s.token_type} #{s.access_token}"
  token = localStorage.getItem 'auth_token'
  #"JWT #{token}"
  "Bearer #{token}"
  
send_auth_header = (xhr) ->
  xhr.setRequestHeader "Authorization", make_auth_header()

auth_sync_options = (options) ->
  options = options || {}
  options.beforeSend = send_auth_header
  options

class AuthModel extends Backbone.Model
  sync: (method, model, options) ->
    options = auth_sync_options options
    super method, model, options

class AuthCollection extends Backbone.Collection
  sync: (method, model, options) ->
    options = auth_sync_options options
    super method, model, options

MainChannel.reply 'main:app:AuthModel', ->
  AuthModel
MainChannel.reply 'main:app:AuthCollection', ->
  AuthCollection
  
module.exports = {}
  
