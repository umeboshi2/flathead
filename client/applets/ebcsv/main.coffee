Marionette = require 'backbone.marionette'
TkApplet = require 'tbirds/tkapplet'

require './dbchannel'
require './ebutil'
Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'

window.ms = require 'ms'

class Router extends Marionette.AppRouter
  appRoutes:
    'ebcsv': 'main_view'

    'ebcsv/xml/upload': 'upload_xml'
    'ebcsv/csv/create': 'create_csv'
    'ebcsv/csv/preview': 'preview_csv'
    
    'ebcsv/cfg': 'list_configs'
    'ebcsv/cfg/list': 'list_configs'
    'ebcsv/cfg/add': 'add_new_config'
    'ebcsv/cfg/view/:name': 'view_config'
    'ebcsv/cfg/edit/:name': 'edit_config'


    'ebcsv/ebcfgs/new': 'add_new_config'
    'ebcsv/ebcfgs/view/:id': 'view_config'
    'ebcsv/ebcfgs/edit/:id': 'edit_config'

    'ebcsv/dsc': 'list_descriptions'
    'ebcsv/dsc/list': 'list_descriptions'
    'ebcsv/dsc/add': 'add_new_description'
    'ebcsv/dsc/view/:name': 'view_description'
    'ebcsv/dsc/edit/:name': 'edit_description'

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
