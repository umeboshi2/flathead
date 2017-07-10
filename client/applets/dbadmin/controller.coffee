{ MainController } = require 'tbirds/controllers'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'dbadmin'
ResourceChannel = Backbone.Radio.channel 'resources'

{ ToolbarAppletLayout } = require 'tbirds/views/layout'


class Controller extends MainController
  layoutClass: ToolbarAppletLayout
  setup_layout_if_needed: ->
    super()
    #@layout.showChildView 'toolbar', new ToolbarView

  mainview: () ->
    @setup_layout_if_needed()
    console.log "List Pages"
    require.ensure [], () =>
      View = require './mainview'
      view = new View
      @layout.showChildView 'content', view
    # name the chunk
    , 'dbadmin-view-mainview'

      
module.exports = Controller

