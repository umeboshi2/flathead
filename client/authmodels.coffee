Backbone = require 'backbone'
navigate_to_url = require 'tbirds/util/navigate-to-url'
jwtDecode = require 'jwt-decode'

MainChannel = Backbone.Radio.channel 'global'

make_auth_header = ->
  # retrieve from local storage on each request
  # to ensure current token
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

class AuthRefresh extends AuthModel
  url: '/auth/refresh'

MainChannel.reply 'main:app:AuthRefresh', ->
  AuthRefresh

MainChannel.reply 'main:app:refresh-token', ->
  refresh = new AuthRefresh
  response = refresh.fetch()
  response.fail ->
    navigate_to_url '#frontdoor/login'
  response.done ->
    token = refresh.get 'token'
    console.log "refresh successful", token
    decoded = jwtDecode token
    console.log "decoded", decoded
    localStorage.setItem 'auth_token', token
    


MainChannel.reply 'main:app:set-auth-token', (token) ->
  localStorage.setItem 'auth_token', token

MainChannel.reply 'main:app:decode-auth-token', ->
  token = localStorage.getItem 'auth_token'
  if token
    jwtDecode token
  else
    {}
    
MainChannel.reply 'main:app:destroy-auth-token', ->
  localStorage.removeItem 'auth_token'
  
    
module.exports = {}
  
