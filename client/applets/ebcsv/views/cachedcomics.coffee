Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
imagesLoaded = require 'imagesloaded'
tc = require 'teacup'

EmptyView = require 'tbirds/views/empty'
ToolbarView = require 'tbirds/views/button-toolbar'
navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ form_group_input_div } = require 'tbirds/templates/forms'

require './base-masonry'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

toolbarEntries = [
  {
    id: 'main'
    label: 'Main View'
    url: '#ebcsv'
    icon: '.fa.fa-eye'
  }
  {
    id: 'browser'
    label: 'Browser'
    url: '#ebcsv'
    icon: '.fa.fa-eye'
  }
  {
    id: 'cfglist'
    label: 'Configs'
    url: '#ebcsv/cfg/list'
    icon: '.fa.fa-list'
  }
  {
    id: 'dsclist'
    label: 'Descriptions'
    url: '#ebcsv/dsc/list'
    icon: '.fa.fa-list'
  }
  {
    id: 'cached'
    label: 'Cached Images'
    url: '#ebcsv/clzpage'
    icon: '.fa.fa-image'
  }
  ]

class CachedComicToolbar extends ToolbarView
  options:
    entryTemplate: tc.renderable (model) ->
      tc.i model.icon
      tc.text " "
      tc.text model.label
  onChildviewToolbarEntryClicked: (child) ->
    @trigger "toolbar:#{child.model.id}:click", child
    console.log "onChildviewToolbarEntryClicked", child.model.id
      
class CachedComicEntryView extends Marionette.View
  template: tc.renderable (model) ->
    img = model.image_src.replace '/lg/', '/sm/'
    img = img.replace 'http://', '//'
    tc.div '.item', ->
      tc.img src:img

class CachedComicCollectionView extends Marionette.CollectionView
  childView: CachedComicEntryView
  emptyView: EmptyView

class ComicListView extends Backbone.Marionette.View
  ui:
    list: '.comiclist-container'
    toolbar: '.images-toolbar'
  regions:
    list: '@ui.list'
    toolbar: '@ui.toolbar'
  template: tc.renderable (model) ->
    tc.div ->
      tc.div '.images-toolbar'
      #tc.div '#comiclist-container.listview-list'
      tc.div '.btn.btn-default'
      tc.div '.comiclist-container'
  onRender: ->
    toolbar = new CachedComicToolbar
      collection: new Backbone.Collection toolbarEntries
    @showChildView 'toolbar', toolbar
    view = new CachedComicCollectionView
      collection: @collection
    @showChildView 'list', view

  onBeforeDestroy: ->
    @masonry.destroy()
    
  onDomRefresh: () ->
    #console.log 'onDomRefresh called on ComicListView'
    @masonry = new Masonry ".comiclist-container",
      gutter: 1
      isInitLayout: false
      itemSelector: '.item'
      columnWidth: 10
      horizontalOrder: true
    @set_layout()
    AppChannel.request 'set-masonry-layout', @masonry

  set_layout: ->
    items = $ '.item'
    imagesLoaded items, =>
      @masonry.reloadItems()
      @masonry.layout()

class ComicMainView extends Marionette.View
  ui:
    content: '.content-container'
    toolbar: '.images-toolbar'
  regions:
    content: '@ui.content'
    toolbar: '@ui.toolbar'
  template: tc.renderable (model) ->
    tc.div ->
      tc.div '.images-toolbar'
      #tc.div '#comiclist-container.listview-list'
      tc.div '.btn.btn-default'
      tc.div '.content-container'
  onRender: ->
    toolbar = new CachedComicToolbar
      collection: new Backbone.Collection toolbarEntries
    @showChildView 'toolbar', toolbar
  

  childViewEvents:
    'toolbar:browser:click': 'view_local_storage'
    'toolbar:main:click': 'main_view'
    'toolbar:cfglist:click': 'show_empty'

  show_empty: ->
    view = new EmptyView
    @showChildView 'content', view
    
  view_local_storage: ->
        
    cachedImages = new Backbone.Collection
    view = new CachedComicCollectionView
      collection: new Backbone.Collection cachedImages
    local_urls = AppChannel.request 'get-comic-image-urls'
    # FIXME we should do this better
    Object.keys local_urls, (key) ->
      item =
        url: key
        image_src: local_urls[key]
      if key != 'id'
        cachedImages.add item
    @showChildView 'content', view
    
  main_view: ->
    view = new CachedComicCollectionView
      collection: @collection
    @showChildView 'content', view
    
  onChildviewToolbarEntryClicked: (child) ->
    @trigger "toolbar:#{child.model.id}:click", child
    console.log "****onChildviewToolbarEntryClicked", child.model.id

module.exports = ComicMainView


