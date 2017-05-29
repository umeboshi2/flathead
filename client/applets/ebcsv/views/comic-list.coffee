$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
imagesLoaded = require 'imagesloaded'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'

ComicEntryView = require './comic-entry'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

class ComicCollectionView extends Backbone.Marionette.CollectionView
  childView: ComicEntryView

class ComicListView extends Backbone.Marionette.View
  regions:
    list: '#comiclist-container'
  template: tc.renderable (model) ->
    tc.div ->
      #tc.div '#comiclist-container.listview-list'
      tc.div '#comiclist-container'
  onRender: =>
    view = new ComicCollectionView
      collection: @collection
    @showChildView 'list', view

  onBeforeDestroy: ->
    @masonry.destroy()
    
  onDomRefresh: () ->
    #console.log 'onDomRefresh called on ComicListView'
    @masonry = new Masonry "#comiclist-container",
      gutter: 1
      isInitLayout: false
      itemSelector: '.item'
      columnWidth: 10
      horizontalOrder: true
    @set_layout()
    AppChannel.reply 'reload-layout', =>
      @set_layout()
      

  set_layout: ->
    items = $ '.item'
    imagesLoaded items, =>
      @masonry.reloadItems()
      @masonry.layout()
    
module.exports = ComicListView


