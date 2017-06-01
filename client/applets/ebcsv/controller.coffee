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
      tc.div '#main-view-button.btn.btn-default', ->
        tc.i '.fa.fa-eye', ' Main View'
      tc.div '#list-configs-button.btn.btn-default', ->
        tc.i '.fa.fa-list', ' List Configs'
      tc.div '#list-dscs-button.btn.btn-default', ->
        tc.i '.fa.fa-list', ' List Descriptions'
      tc.div '#upload-xml-button.btn.btn-default', ->
        tc.i '.fa.fa-upload', ' Upload XML'
      tc.div '#mkcsv-button.btn.btn-default', ->
        tc.i '.fa.fa-cubes', ' Create CSV'
      tc.div '#new-config-button.btn.btn-default', ->
        tc.i '.fa.fa-plus', ' New Config'
      tc.div '#list-heroes-button.btn.btn-default', ->
        tc.i '.fa.fa-list', ' Heroes'
  ui:
    main_view_btn: '#main-view-button'
    list_btn: '#list-configs-button'
    list_dsc_btn: '#list-dscs-button'
    newcfg_btn: '#new-config-button'
    uploadxml_btn: '#upload-xml-button'
    mkcsv_btn: '#mkcsv-button'
    list_hero_btn: '#list-heroes-button'
    
  events:
    'click @ui.main_view_btn': 'show_main_view'
    'click @ui.list_btn': 'list_configs'
    'click @ui.list_dsc_btn': 'list_descriptions'
    'click @ui.newcfg_btn': 'add_new_config'
    'click @ui.uploadxml_btn': 'upload_xml'
    'click @ui.mkcsv_btn': 'make_csv'
    'click @ui.list_hero_btn': 'list_heroes'

  show_main_view: ->
    navigate_to_url '#ebcsv'
    
  list_configs: ->
    navigate_to_url '#ebcsv/cfg/list'
    
  list_descriptions: ->
    navigate_to_url '#ebcsv/dsc/list'

  list_heroes: ->
    navigate_to_url '#ebcsv/hero/list'

  add_new_config: ->
    navigate_to_url '#ebcsv/cfg/add'

  upload_xml: ->
    navigate_to_url '#ebcsv/xml/upload'

  make_csv: ->
    navigate_to_url '#ebcsv/csv/create'
    
class Controller extends MainController
  layoutClass: ToolbarAppletLayout
  setup_layout_if_needed: ->
    super()
    @layout.showChildView 'toolbar', new ToolbarView

  
  ############################################
  # ebcsv main views
  ############################################
  _show_main_view: =>
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/mainview'
      view = new View
        collection: comics
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-main-view-helper'

  _show_create_csv_view: =>
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/mkcsv'
      view = new View
        collection: comics
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-mkcsv-view-helper'
    
  _show_preview_csv_view: =>
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/csvpreview'
      view = new View
        collection: comics
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-csvpreview-view-helper'
    
  _need_comics_view: (cb) ->
    comics = AppChannel.request 'get-comics'
    if not comics.length
      if __DEV__
        window.comics = comics
        xml_url = '/assets/dev/comics.xml'
        xhr = Backbone.ajax
          type: 'GET'
          dataType: 'text'
          url: xml_url
        xhr.done ->
          content = xhr.responseText
          AppChannel.request 'parse-comics-xml', content, (err, json) ->
            #@_show_main_view()
            cb()
        xhr.fail ->
          navigate_to_url '#ebcsv/xml/upload'
      else
        navigate_to_url '#ebcsv/xml/upload'
    else
      cb()
      
  create_csv: =>
    @setup_layout_if_needed()
    cfgs = AppChannel.request 'ebcfg-collection'
    dscs = AppChannel.request 'ebdsc-collection'
    cfgs.fetch().then =>
      dscs.fetch().then =>
        @_need_comics_view @_show_create_csv_view
    
  preview_csv: =>
    @setup_layout_if_needed()
    cfg = AppChannel.request 'get-current-csv-cfg'
    dsc = AppChannel.request 'get-current-csv-dsc'
    hlist = AppChannel.request 'get-superheroes-model'
    if cfg is undefined
      if __DEV__
        cfg = AppChannel.request 'get-ebcfg', 1
        dsc = AppChannel.request 'get-ebdsc', 1
        AppChannel.request 'set-current-csv-cfg', cfg
        AppChannel.request 'set-current-csv-dsc', dsc
        cfg.fetch().then =>
          dsc.fetch().then =>
            hlist.fetch().then =>
              @_need_comics_view @_show_preview_csv_view
      else
        navigate_to_url '#ebcsv'
        return
    else
      cfg.fetch().then =>
        dsc.fetch().then =>
          hlist.fetch().then =>
            @_need_comics_view @_show_preview_csv_view
    
  main_view: =>
    @setup_layout_if_needed()
    @_need_comics_view @_show_main_view
    
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
    
    
  list_heroes: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      collection = AppChannel.request 'ebhero-collection'
      response = collection.fetch()
      response.done =>
        View = require './views/superheroes'
        view = new View
          collection: collection
        @layout.showChildView 'content', view
      response.fail ->
        MessageChannel.request 'danger', 'Failed to get configs'
    # name the chunk
    , 'ebcsv-view-list-configs'

  view_comic_json: (comic_id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      comic = comics.get comic_id
      View = require './views/comicjson'
      view = new View
        model: comic
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-comic-json'
    
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

