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
    'sofi': 'main_view'

    'sofi/comics': 'dbcomics_main'
    'sofi/comics/local': 'view_local_comics'

    'sofi/comics/photos/:comic_id': 'manageComicPhotos'
    'sofi/comics/workspace': 'showWorkspaceView'

    'sofi/xml/upload': 'upload_xml'
    'sofi/csv/create': 'create_csv'
    'sofi/csv/preview': 'preview_csv'

    'sofi/clzpage' : 'view_cached_comics'
    

class Applet extends TkApplet
  appletName: 'sofi'
  channelName: 'sofi'
  Controller: Controller
  Router: Router
  extraRouters:
    cfg: require './routers/cfg'
    dsc: require './routers/dsc'
      
module.exports = Applet
