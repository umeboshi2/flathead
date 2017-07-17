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
CrudController = MainChannel.request 'main:app:CrudController'


class DscController extends CrudController
  channelName: 'ebcsv'
  objName: 'description'
  modelName: 'ebdsc'
  initialize: (options) ->
    @applet = MainChannel.request 'main:applet:get-applet', 'ebcsv'
    @mainController = @applet.router.controller
    @channel = @getChannel()
    
  ############################################
  # ebcsv descriptions
  ############################################
  list_descriptions: ->
    require.ensure [], () =>
      ViewClass = require './dsclist'
      @listItems ViewClass
    # name the chunk
    , 'ebcsv-view-list-descriptions'
    
  add_new_description: ->
    require.ensure [], () =>
      { NewFormView } = require './dscedit'
      @addItem NewFormView
    # name the chunk
    , 'ebcsv-view-add-dsc'

  view_description: (id) ->
    require.ensure [], () =>
      ViewClass = require './dscview'
      @viewItem ViewClass, id
    # name the chunk
    , 'ebcsv-view-description'
    
  edit_description: (id) ->
    require.ensure [], () =>
      { EditFormView } = require './dscedit'
      @editItem EditFormView, id
    # name the chunk
    , 'ebcsv-edit-description'

module.exports = DscController

