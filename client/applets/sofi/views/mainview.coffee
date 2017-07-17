$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
EmptyView = require 'tbirds/views/empty'
ToolbarView = require 'tbirds/views/button-toolbar'

ComicListView = require './comic-list'
MarkdowView = require './mdview'
UploadView = require './upload-comics'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

class ChildToolbar extends ToolbarView
  # skip navigating to url and bubble event up
  # to list view
  onChildviewToolbarEntryClicked: ->
  childViewTriggers:
    'toolbar:entry:clicked': 'toolbar:entry:clicked'


toolbarEntries = [
  {
    id: 'main'
    label: 'Main View'
    icon: '.fa.fa-home'
  }
  {
    id: 'curlist'
    label: 'Current Comics'
    icon: '.fa.fa-list'
  }
  {
    id: 'scandb'
    label: 'Scan Database for Comics'
    icon: '.fa.fa-search.fa-spin'
  }
  {
    id: 'upload'
    label: 'Upload Comics'
    icon: '.fa.fa-upload'
  }
]

class ComicsView extends Marionette.View
  regions:
    toolbar: '.toolbar'
    body: '.body'
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "CLZ XML to EBay File Exchange CSV"
    tc.div '.toolbar'
    tc.div '.body'
    
  showToolbar: ->
    toolbar = new ChildToolbar
      collection: new Backbone.Collection toolbarEntries
    @showChildView 'toolbar', toolbar
    
  showMainDoc: ->
    doc = MainChannel.request 'main:app:get-document', 'sofi-main'
    response = doc.fetch()
    response.done =>
      view = new MarkdowView
        model: doc
      @showChildView 'body', view
    response.fail ->
      MessageChannel.request 'danger', 'failed to get document'
      
  showLocalList: ->
    view = new ComicListView
      collection: AppChannel.request 'get-comics'
    @showChildView 'body', view
    
  showUploadView: ->
    view = new UploadView
    @showChildView 'body', view
    
  onRender: ->
    comics = AppChannel.request 'get-comics'
    if comics.length
      @showToolbar()
      @showLocalList()
    else
      @showMainDoc()
  onChildviewToolbarEntryClicked: (child) ->
    button = child.model.id
    if button is 'curlist'
      @showLocalList()
    else if button is 'main'
      @showMainDoc()
    else if button is 'scandb'
      @scanDatabase()
    else if button is 'upload'
      @showUploadView()
    else
      MessageChannel.request 'danger', 'No good, dude.'
      
  scanDatabase: ->
    MessageChannel.request 'info', "scan the database for these comics."
    
module.exports = ComicsView


