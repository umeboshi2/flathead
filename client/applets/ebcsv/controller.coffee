$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ MainController } = require 'tbirds/controllers'
ToolbarView = require 'tbirds/views/button-toolbar'
ShowInitialEmptyContent = require 'tbirds/behaviors/show-initial-empty'
SlideDownRegion = require 'tbirds/regions/slidedown'

EbCsvToolbar = require './applet-toolbar'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'ebcsv'



class ToolbarAppletLayout extends Backbone.Marionette.View
  behaviors:
    ShowInitialEmptyContent:
      behaviorClass: ShowInitialEmptyContent
  template: tc.renderable (model) ->
    tc.div '.col-sm-12', ->
      tc.div '.row', ->
        tc.div  '#main-toolbar.col-sm-10.col-sm-offset-1'
      tc.div '.row', ->
        tc.div '#main-content.col-sm-10.col-sm-offset-1'
  regions: ->
    region = new SlideDownRegion
      el: '#main-content'
    region.slide_speed = ms '.01s'
    content: region
    toolbar: '#main-toolbar'

button_style = "overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"

defaultColumns = ['id', 'name']

class EbCsvToolbar extends ToolbarView
  options:
    entryTemplate: tc.renderable (model) ->
      opts =
        style: button_style
      tc.span opts, ->
        tc.i model.icon
        tc.text " "
        tc.text model.label

class Controller extends MainController
  layoutClass: ToolbarAppletLayout
  setup_layout_if_needed: ->
    super()
    toolbar = new EbCsvToolbar
      collection: AppChannel.request 'get-toolbar-entries'
    @layout.showChildView 'toolbar', toolbar

  
  ############################################
  # ebcsv main views
  ############################################
  _show_main_view: =>
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/mainview'
      view = new View
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
    if comics.length
      cb()
    else
      @navigate_to_url '#ebcsv/xml/upload'
      
  create_csv: =>
    @setup_layout_if_needed()
    cfgs = AppChannel.request 'db:ebcfg:collection'
    dscs = AppChannel.request 'db:ebdsc:collection'
    options =
      data:
        columns: defaultColumns
    cfgs.fetch(options).then =>
      dscs.fetch(options).then =>
        @_need_comics_view @_show_create_csv_view
    
  preview_csv: ->
    @setup_layout_if_needed()
    cfg = AppChannel.request 'locals:get', 'currentCsvCfg'
    dsc = AppChannel.request 'locals:get', 'currentCsvDsc'
    hlist = AppChannel.request 'get-superheroes-model'
    if cfg is undefined
      @navigate_to_url '#ebcsv'
      return
    else
      cfg.fetch().then =>
        dsc.fetch().then =>
          hlist.fetch().then =>
            @_need_comics_view @_show_preview_csv_view
    
  main_view: ->
    @setup_layout_if_needed()
    @_show_main_view()

  dbcomics_main: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/mainview'
      view = new View
        collection: comics
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv:views:mainview'

  _showLocalComics: =>
    require.ensure [], () =>
      comics = AppChannel.request 'get-comics'
      View = require './views/comic-list'
      view = new View
        collection: comics
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv:views:'
    
  view_local_comics: ->
    @setup_layout_if_needed()
    @_need_comics_view @_showLocalComics
    
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
    
  view_cached_comics: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/cachedcomics'
      view = new View
      @layout.showChildView 'content', view
    # name the chunk
    , 'ebcsv-view-cached-comics-view'
    
    
module.exports = Controller
