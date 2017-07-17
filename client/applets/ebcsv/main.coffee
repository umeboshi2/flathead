Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
TkApplet = require 'tbirds/tkapplet'

require './dbchannel'
require './ebutils'


Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'

class Router extends Marionette.AppRouter
  appRoutes:
    'ebcsv': 'main_view'

    'ebcsv/comics': 'dbcomics_main'
    'ebcsv/comics/local': 'view_local_comics'

    'ebcsv/xml/upload': 'upload_xml'
    'ebcsv/csv/create': 'create_csv'
    'ebcsv/csv/preview': 'preview_csv'

    'ebcsv/clzpage' : 'view_cached_comics'
    

class Applet extends TkApplet
  appletName: 'ebcsv'
  channelName: 'ebcsv'
  Controller: Controller
  Router: Router
  extraRouters:
    cfg: require './routers/cfg'
    dsc: require './routers/dsc'
      
module.exports = Applet
