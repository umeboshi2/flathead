$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
EmptyView = require 'tbirds/views/empty'
ToolbarView = require 'tbirds/views/button-toolbar'

ComicEntryView = require './comic-entry'
ComicListView = require './comic-list'
MarkdowView = require './mdview'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

#class ComicListView extends Backbone.Marionette.CollectionView
#  childView: ComicEntryView


toolbarEntries = [
  {
    id: 'main'
    label: 'Main'
    icon: '.fa.fa-home'
    url: '#ebcsv'
  }
  {
    id: 'curlist'
    label: 'Current'
    icon: '.fa.fa-list'
    url: '#ebcsv/comics/local'
  }
]

class ComicsView extends Backbone.Marionette.View
  regions:
    #list: '#comiclist-container'
    toolbar: '.toolbar'
    body: '.body'
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "CLZ XML to EBay File Exchange CSV"
    tc.div '.toolbar'
    tc.div '.body'
  onRender: ->
    toolbar = new ToolbarView
      collection: new Backbone.Collection toolbarEntries
    @showChildView 'toolbar', toolbar
    doc = MainChannel.request 'main:app:get-document', 'ebcsv-main'
    response = doc.fetch()
    response.done =>
      view = new MarkdowView
        model: doc
      @showChildView 'body', view
    response.fail ->
      MessageChannel.request 'danger', 'failed to get document'
    
module.exports = ComicsView


