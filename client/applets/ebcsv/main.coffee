Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
TkApplet = require 'tbirds/tkapplet'

require './dbchannel'
require './ebutils'


Controller = require './controller'
CfgController = require './cfg-controller'
DscController = require './dsc-controller'

class CfgRouter extends Marionette.AppRouter
  appRoutes:
    'ebcsv/cfg': 'list_configs'
    'ebcsv/cfg/list': 'list_configs'
    'ebcsv/cfg/add': 'add_new_config'
    'ebcsv/cfg/view/:name': 'view_config'
    'ebcsv/cfg/edit/:name': 'edit_config'
    # FIXME get rid of these
    # tbirds basecrud templates uses this
    # url pattern
    'ebcsv/ebcfgs/new': 'add_new_config'
    'ebcsv/ebcfgs/view/:id': 'view_config'
    'ebcsv/ebcfgs/edit/:id': 'edit_config'

class DscRouter extends Marionette.AppRouter
  appRoutes:
    'ebcsv/dsc': 'list_descriptions'
    'ebcsv/dsc/list': 'list_descriptions'
    'ebcsv/dsc/add': 'add_new_description'
    'ebcsv/dsc/view/:name': 'view_description'
    'ebcsv/dsc/edit/:name': 'edit_description'
    # FIXME get rid of these
    'ebcsv/ebdscs/new': 'add_new_description'
    'ebcsv/ebdscs/view/:id': 'view_description'
    'ebcsv/ebdscs/edit/:id': 'edit_description'

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
  Controller: Controller
  Router: Router
  extraRouters:
    cfg:
      router: CfgRouter
      controller: CfgController
    dsc:
      router: DscRouter
      controller: DscController
      
      
module.exports = Applet
