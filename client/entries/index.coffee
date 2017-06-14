Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
jwtDecode = require 'jwt-decode'
ms = require 'ms'

navigate_to_url = require 'tbirds/util/navigate-to-url'
TopApp = require 'tbirds/top-app'

require './base'
pkg = require '../../package.json'
pkgmodel = new Backbone.Model pkg

MainAppConfig = require './index-config'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

class FooterView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div "Version: #{model.version}"
    if model.remaining >= 0
      tc.div "#{model.remaining} seconds left for #{model.token.name}"
    else
      tc.div "Time expired for #{model.token.name}"
    
app = new TopApp
  appConfig: MainAppConfig

access_time_remaining = ->
  token = MainChannel.request 'main:app:decode-auth-token'
  if not token
    return 0
  now = new Date()
  exp = new Date(token.exp * 1000)
  remaining = Math.floor((exp - now) / 1000)
  return remaining
  
show_footer = ->
  token = MainChannel.request 'main:app:decode-auth-token'
  pkgmodel.set 'token', token
  pkgmodel.set 'remaining', access_time_remaining()
  view = new FooterView
    model: pkgmodel
  footer_region = app.getView().getRegion 'footer'
  footer_region.show view
  
app.on 'before:start', ->
  theme = MainChannel.request 'main:app:get-theme'
  theme = if theme then theme else 'vanilla'
  MainChannel.request 'main:app:switch-theme', theme
  remaining = access_time_remaining()
  if remaining <= 0
    MessageChannel.request 'warning', 'deleting expired access token'
    MainChannel.request 'main:app:destroy-auth-token'
  AuthRefresh = MainChannel.request 'main:app:AuthRefresh'
  refresh = new AuthRefresh
  response = refresh.fetch()
  response.fail ->
    if response.status == 401
      console.log "auth failed"
      window.location.hash = "#frontdoor/login"
    else
      console.log "failed!!!", response
    #navigate_to_url '#frontdoor/login'
  response.done ->
    token = refresh.get 'token'
    console.log "refresh successful", token
    decoded = jwtDecode token
    console.log "decoded", decoded
    localStorage.setItem 'auth_token', token

app.on 'start', ->
  #show_footer()
  setInterval show_footer, ms '1s'
  
  
if __DEV__
  # DEBUG attach app to window
  window.App = app

# register the main router
MainChannel.request 'main:app:route'

# start the app
app.start()

  
module.exports = app


