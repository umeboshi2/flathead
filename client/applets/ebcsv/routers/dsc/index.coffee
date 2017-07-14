Marionette = require 'backbone.marionette'

DscController = require './controller'

class DscRouter extends Marionette.AppRouter
  appRoutes:
    'ebcsv/dsc': 'list_descriptions'
    'ebcsv/dsc/list': 'list_descriptions'
    'ebcsv/dsc/add': 'add_new_description'
    'ebcsv/dsc/view/:name': 'view_description'
    'ebcsv/dsc/edit/:name': 'edit_description'
    # FIXME get rid of these
    # tbirds basecrud templates uses this
    # url pattern
    'ebcsv/ebdscs/new': 'add_new_description'
    'ebcsv/ebdscs/view/:id': 'view_description'
    'ebcsv/ebdscs/edit/:id': 'edit_description'

module.exports =
  router: DscRouter
  controller: DscController
  
