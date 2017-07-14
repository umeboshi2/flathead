$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ ExtraController } = require 'tbirds/controllers'
ToolbarView = require 'tbirds/views/button-toolbar'
ShowInitialEmptyContent = require 'tbirds/behaviors/show-initial-empty'
SlideDownRegion = require 'tbirds/regions/slidedown'

EbCsvToolbar = require './applet-toolbar'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'ebcsv'

defaultColumns = ['id', 'name']

class CfgController extends ExtraController
  channelName: 'ebcsv'
  initialize: (options) ->
    @applet = MainChannel.request 'main:applet:get-applet', 'ebcsv'
    @mainController = @applet.router.controller
    @channel = @getChannel()
  setup_layout_if_needed: ->
    @mainController.setup_layout_if_needed()
  showChildView: (region, view) ->
    @mainController.layout.showChildView region, view
  ############################################
  # ebcsv configs
  ############################################
  list_configs: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      cfgs = @channel.request 'db:ebcfg:collection'
      response = cfgs.fetch
        data:
          columns: defaultColumns
      response.done =>
        View = require './views/cfglist'
        view = new View
          collection: cfgs
        @showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get configs'
    # name the chunk
    , 'ebcsv-view-list-configs'
    
  add_new_config: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './views/cfgedit'
      view = new Views.NewFormView
      @showChildView 'content', view
      @scroll_top()
    # name the chunk
    , 'ebcsv-view-add-cfg'

  view_config: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/cfgview'
      model = AppChannel.request 'db:ebcfg:get', id
      response = model.fetch()
      response.done =>
        view = new View
          model: model
        @showChildView 'content', view
        @scroll_top()
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get configs'
    # name the chunk
    , 'ebcsv-view-config'
    
  edit_config: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './views/cfgedit'
      model = AppChannel.request 'db:ebcfg:get', id
      response = model.fetch()
      response.done =>
        view = new Views.EditFormView
          model: model
        @showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get configs'
    # name the chunk
    , 'ebcsv-edit-config'

module.exports = CfgController

