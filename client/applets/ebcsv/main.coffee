Marionette = require 'backbone.marionette'
TkApplet = require 'tbirds/tkapplet'

require './dbchannel'
Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'



class Router extends Marionette.AppRouter
  appRoutes:
    'ebcsv': 'list_configs'
    'ebcsv/listconfigs': 'list_configs'
    'ebcsv/addcfg': 'add_new_config'
    'ebcsv/viewcfg/:name': 'view_config'
    'ebcsv/editcfg/:name': 'edit_config'
    
class Applet extends TkApplet
  Controller: Controller
  Router: Router

  onBeforeStart: ->
    super arguments
    MainChannel.reply 'applet:ebcsv:router', =>
      @router
    MainChannel.reply 'applet:ebcsv:controller', =>
      @router.controller

MainChannel.reply 'applet:ebcsv:route', () ->
  console.warn "Don't use applet:ebcsv:route"
  controller = new Controller MainChannel
  router = new Router
    controller: controller
  MainChannel.reply 'applet:ebcsv:router', ->
    router
  MainChannel.reply 'applet:ebcsv:controller', ->
    controller
    
module.exports = Applet
