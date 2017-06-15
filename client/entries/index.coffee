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
    version_style = '.col-sm-2.col-sm-offset-10'
    timestyle = '.col-sm-2.col-sm-offset-1'
    tc.div '.col-sm-10.col-sm-offset-1', ->
      tc.table '.table', ->
        tc.tr ->
          if model.remaining >= 0
            tc.td "#{model.remaining} seconds left for #{model.token.name}"
          else
            tc.td "Time expired for #{model.token.name}"
          tc.td "Version: #{model.version}"
            
app = new TopApp
  appConfig: MainAppConfig

ms_remaining = (token) ->
  now = new Date()
  exp = new Date(token.exp * 1000)
  return exp - now
  
access_time_remaining = ->
  token = MainChannel.request 'main:app:decode-auth-token'
  if not token
    return 0
  remaining = ms_remaining token
  return Math.floor(remaining / 1000)
  
show_footer = ->
  token = MainChannel.request 'main:app:decode-auth-token'
  pkgmodel.set 'token', token
  pkgmodel.set 'remaining', access_time_remaining()
  view = new FooterView
    model: pkgmodel
  footer_region = app.getView().getRegion 'footer'
  footer_region.show view

refresh_token = ->
  AuthRefresh = MainChannel.request 'main:app:AuthRefresh'
  refresh = new AuthRefresh
  response = refresh.fetch()
  response.fail ->
    if response.status == 401
      window.location.hash = "#frontdoor/login"
    else
      msg = 'There was a problem refreshing the access token'
      MessageChannel.request 'warning', msg
  response.done ->
    token = refresh.get 'token'
    decoded = jwtDecode token
    localStorage.setItem 'auth_token', token

keep_token_fresh = ->
  token = MainChannel.request 'main:app:decode-auth-token'
  remaining = ms_remaining token
  #console.log 'remaining', remaining
  if remaining < ms '30s'
    MainChannel.request 'main:app:refresh-token'
    
    
  
app.on 'before:start', ->
  theme = MainChannel.request 'main:app:get-theme'
  theme = if theme then theme else 'vanilla'
  MainChannel.request 'main:app:switch-theme', theme
  remaining = access_time_remaining()
  if remaining <= 0
    MessageChannel.request 'warning', 'deleting expired access token'
    MainChannel.request 'main:app:destroy-auth-token'
  MainChannel.request 'main:app:refresh-token'
  

app.on 'start', ->
  show_footer()
  setInterval show_footer, ms '1m'
  setInterval keep_token_fresh, ms '10s'
  
  
if __DEV__
  # DEBUG attach app to window
  window.App = app

# register the main router
MainChannel.request 'main:app:route'

# start the app
app.start()

  
module.exports = app


