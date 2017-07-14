Marionette = require 'backbone.marionette'

CfgController = require './controller'

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

module.exports =
  router: CfgRouter
  controller: CfgController
  
