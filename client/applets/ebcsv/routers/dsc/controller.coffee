$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ ExtraController } = require 'tbirds/controllers'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

defaultColumns = ['id', 'name']

class DscController extends ExtraController
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
  # ebcsv descriptions
  ############################################
  list_descriptions: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      dscs = AppChannel.request 'db:ebdsc:collection'
      response = dscs.fetch
        data:
          columns: defaultColumns
      response.done =>
        View = require './dsclist'
        view = new View
          collection: dscs
        @showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get descriptions'
    # name the chunk
    , 'ebcsv-view-list-descriptions'
    
  add_new_description: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './dscedit'
      view = new Views.NewFormView
      @showChildView 'content', view
      @scroll_top()
    # name the chunk
    , 'ebcsv-view-add-dsc'

  view_description: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './dscview'
      model = AppChannel.request 'db:ebdsc:get', id
      response = model.fetch()
      response.done =>
        view = new View
          model: model
        @showChildView 'content', view
        @scroll_top()
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get descriptions'
    # name the chunk
    , 'ebcsv-view-description'
    
  edit_description: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './dscedit'
      model = AppChannel.request 'db:ebdsc:get', id
      response = model.fetch()
      response.done =>
        view = new Views.EditFormView
          model: model
        @showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get descriptions'
    # name the chunk
    , 'ebcsv-edit-description'

module.exports = DscController

