Marionette = require 'backbone.marionette'
TkApplet = require 'tbirds/tkapplet'

require './dbchannel'
Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'



class Router extends Marionette.AppRouter
  appRoutes:
    'ebcsv': 'config_view'
    #'ebcsv/documents': 'list_pages'
    #'ebcsv/documents/new': 'new_page'
    #'ebcsv/documents/view/:id': 'view_page'
    #'ebcsv/documents/edit/:id': 'edit_page'
    
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
