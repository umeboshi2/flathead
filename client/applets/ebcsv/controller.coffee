{ MainController } = require 'tbirds/controllers'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'ebcsv'

{ ToolbarAppletLayout } = require 'tbirds/views/layout'


class Controller extends MainController
  layoutClass: ToolbarAppletLayout
  setup_layout_if_needed: ->
    super()
    #@layout.showChildView 'toolbar', new ToolbarView

  collection: ResourceChannel.request 'document-collection'

  config_view: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/cfgview'
      settings = AppChannel.request 'get_ebcsv_settings'
      view = new View
        model: settings
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-config'
    
  list_pages: () ->
    @setup_layout_if_needed()
    console.log "List Pages"
    require.ensure [], () =>
      ListView = require './views/pagelist'
      view = new ListView
        collection: @collection
      response = @collection.fetch()
      response.done =>
        @layout.showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', "Failed to load documents."
    # name the chunk
    , 'ebcsv-view-list-pages'

  edit_page: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { EditPageView } = require './views/editor'
      model = ResourceChannel.request 'get-document', id
      @_load_view EditPageView, model
    # name the chunk
    , 'ebcsv-view-edit-page'
      
  view_page: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      PageView = require './views/pageview'
      model = ResourceChannel.request 'get-document', id
      @_load_view PageView, model
    # name the chunk
    , 'ebcsv-view-doc-page'
      
  new_page: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { NewPageView } = require './views/editor'
      view = new NewPageView
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-new-page'
      
      
module.exports = Controller

