Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
jwtDecode = require 'jwt-decode'

navigate_to_url = require 'tbirds/util/navigate-to-url'
TopApp = require 'tbirds/top-app'

require './base'
pkg = require '../../package.json'

MainAppConfig = require './index-config'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

class FooterView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div "Version: #{model.version}"

app = new TopApp
  appConfig: MainAppConfig

app.on 'before:start', ->
  theme = MainChannel.request 'main:app:get-theme'
  theme = if theme then theme else 'vanilla'
  MainChannel.request 'main:app:switch-theme', theme

app.on 'start', ->
  pkgmodel = new Backbone.Model pkg
  view = new FooterView
    model: pkgmodel
  footer_region = app.getView().getRegion 'footer'
  footer_region.show view
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
    
  
if __DEV__
  # DEBUG attach app to window
  window.App = app

# register the main router
MainChannel.request 'main:app:route'

# start the app
app.start()

  
module.exports = app


