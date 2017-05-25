Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ MainController } = require 'tbirds/controllers'
{ ToolbarAppletLayout } = require 'tbirds/views/layout'
navigate_to_url = require 'tbirds/util/navigate-to-url'
scroll_top_fast = require 'tbirds/util/scroll-top-fast'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'ebcsv'

class ToolbarView extends Backbone.Marionette.View
  template: tc.renderable () ->
    tc.div '.btn-group.btn-group-justified', ->
      tc.div '#list-configs-button.btn.btn-default', ->
        tc.i '.fa.fa-list', ' List Configs'
      tc.div '#new-config-button.btn.btn-default', ->
        tc.i '.fa.fa-plus', ' New Config'
    tc.div '.input-group', ->
      tc.input '.form-control', type:'text', placeholder:'search',
      name:'search'
      tc.span '.input-group-btn', ->
        tc.button '#search-button.btn.btn-default', ->
          tc.i '.fa.fa-search', 'Search'
        
  ui:
    list_btn: '#list-configs-button'
    newcfg_btn: '#new-config-button'
    search_bth: '#search-button'
    show_cal_btn: '#show-calendar-button'
    search_entry: '.form-control'
    
  events:
    'click @ui.list_btn': 'list_configs'
    'click @ui.newcfg_btn': 'add_new_config'
    'click @ui.search_bth': 'search_hubby'

  show_calendar: ->
    hash = '#hubby'
    if window.location.hash == hash
      controller = HubChannel.request 'main-controller'
      controller.mainview()
    else
      if __DEV__
        console.log "current url", window.location
      navigate_to_url '#hubby'

  list_configs: ->
    navigate_to_url '#ebcsv/listconfigs'

  add_new_config: ->
    navigate_to_url '#ebcsv/addcfg'
    
  list_meetings: ->
    navigate_to_url '#hubby/listmeetings'

  search_hubby: ->
    controller = HubChannel.request 'main-controller'
    options =
      searchParams:
        title: @ui.search_entry.val()
    console.log "search for", options
    controller.view_items options
    

class Controller extends MainController
  layoutClass: ToolbarAppletLayout
  setup_layout_if_needed: ->
    super()
    @layout.showChildView 'toolbar', new ToolbarView

  collection: ResourceChannel.request 'document-collection'

  list_configs: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      cfgs = AppChannel.request 'get_local_configs'
      View = require './views/cfglist'
      view = new View
        collection: cfgs
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-list-configs'
    
  add_new_config: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/newcfg'
      view = new View
      @layout.showChildView 'content', view
      scroll_top_fast()
    # name the chunk
    , 'ebcsv-view-add-cfg'

  view_config: (name) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      model = AppChannel.request 'get-ebcsv-config', name
      View = require './views/cfgview'
      view = new View
        model: model
      @layout.showChildView 'content', view
      scroll_top_fast()
    # name the chunk
    , 'ebcsv-view-config'
    
  edit_config: (name) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/cfgedit'
      model = AppChannel.request 'get-ebcsv-config', name
      view = new View
        model: model
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-edit-config'

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

