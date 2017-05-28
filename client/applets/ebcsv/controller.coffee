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
      tc.div '#list-dscs-button.btn.btn-default', ->
        tc.i '.fa.fa-list', ' List Descriptions'
      tc.div '#upload-xml-button.btn.btn-default', ->
        tc.i '.fa.fa-upload', ' Upload XML'
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
    list_dsc_btn: '#list-dscs-button'
    newcfg_btn: '#new-config-button'
    uploadxml_btn: '#upload-xml-button'
    search_bth: '#search-button'
    show_cal_btn: '#show-calendar-button'
    search_entry: '.form-control'
    
  events:
    'click @ui.list_btn': 'list_configs'
    'click @ui.list_dsc_btn': 'list_descriptions'
    'click @ui.newcfg_btn': 'add_new_config'
    'click @ui.uploadxml_btn': 'upload_xml'
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
    navigate_to_url '#ebcsv/cfg/list'
    
  list_descriptions: ->
    navigate_to_url '#ebcsv/dsc/list'

  add_new_config: ->
    navigate_to_url '#ebcsv/cfg/add'

  upload_xml: ->
    navigate_to_url '#ebcsv/xml/upload'
    
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

  
  ############################################
  # ebcsv main views
  ############################################
  _show_main_view: ->
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/mainview'
      view = new View
        collection: comics
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-main-view-helper'
    
  main_view: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      if not comics.length
        if __DEV__
          xml_url = '/assets/comics.xml'
          xhr = Backbone.ajax
            type: 'GET'
            dataType: 'text'
            url: xml_url
          xhr.done =>
            content = xhr.responseText
            AppChannel.request 'parse-comics-xml', content, (err, json) =>
              @_show_main_view()
          xhr.fail =>
            navigate_to_url '#ebcsv/xml/upload'
        else
          navigate_to_url '#ebcsv/xml/upload'
      else
        @_show_main_view()
    # name the chunk
    , 'ebcsv-view-main-view'
    
  upload_xml: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/uploadxml'
      view = new View
        collection: comics
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-upload-xml-view'
    
    
  ############################################
  # ebcsv configs
  ############################################
  list_configs: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      cfgs = AppChannel.request 'ebcfg-collection'
      response = cfgs.fetch()
      response.done =>
        View = require './views/cfglist'
        view = new View
          collection: cfgs
        @layout.showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get configs'
    # name the chunk
    , 'ebcsv-view-list-configs'
    
  add_new_config: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './views/cfgedit'
      view = new Views.NewFormView
      @layout.showChildView 'content', view
      scroll_top_fast()
    # name the chunk
    , 'ebcsv-view-add-cfg'

  view_config: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/cfgview'
      model = AppChannel.request 'get-ebcfg', id
      response = model.fetch()
      response.done =>
        view = new View
          model: model
        @layout.showChildView 'content', view
        scroll_top_fast()
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get configs'
    # name the chunk
    , 'ebcsv-view-config'
    
  edit_config: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './views/cfgedit'
      model = AppChannel.request 'get-ebcfg', id
      response = model.fetch()
      response.done =>
        view = new Views.EditFormView
          model: model
        @layout.showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get configs'
    # name the chunk
    , 'ebcsv-edit-config'




  ############################################
  # ebcsv descriptions
  ############################################
  list_descriptions: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      dscs = AppChannel.request 'ebdsc-collection'
      response = dscs.fetch()
      response.done =>
        View = require './views/dsclist'
        view = new View
          collection: dscs
        @layout.showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get descriptions'
    # name the chunk
    , 'ebcsv-view-list-descriptions'
    
  add_new_description: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './views/dscedit'
      view = new Views.NewFormView
      @layout.showChildView 'content', view
      scroll_top_fast()
    # name the chunk
    , 'ebcsv-view-add-dsc'

  view_description: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/dscview'
      model = AppChannel.request 'get-ebdsc', id
      response = model.fetch()
      response.done =>
        view = new View
          model: model
        @layout.showChildView 'content', view
        scroll_top_fast()
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get descriptions'
    # name the chunk
    , 'ebcsv-view-description'
    
  edit_description: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      Views = require './views/dscedit'
      model = AppChannel.request 'get-ebdsc', id
      response = model.fetch()
      response.done =>
        view = new Views.EditFormView
          model: model
        @layout.showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get descriptions'
    # name the chunk
    , 'ebcsv-edit-description'

module.exports = Controller

