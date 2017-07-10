Marionette = require 'backbone.marionette'
TkApplet = require 'tbirds/tkapplet'

require './dbchannel'
Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'dbadmin'



class Router extends Marionette.AppRouter
  appRoutes:
    'dbadmin': 'mainview'
    #'dbadmin': 'list_pages'
    #'dbadmin/documents': 'list_pages'
    #'dbadmin/documents/new': 'new_page'
    #'dbadmin/documents/view/:id': 'view_page'
    #'dbadmin/documents/edit/:id': 'edit_page'
    
class Applet extends TkApplet
  Controller: Controller
  Router: Router

module.exports = Applet
