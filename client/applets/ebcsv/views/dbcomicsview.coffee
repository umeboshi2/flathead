$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'
dateFormat = require 'dateformat'
#require('editable-table/mindmup-editabletable')

DbComicEntry = require './dbcomic-entry'
HasHeader = require './has-header'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

default_entry_template = tc.renderable (model) ->
  tc.div "default_entry_template"
  

class DbComicEntryCollectionView extends Marionette.NextCollectionView
  childView: DbComicEntry
    
class DbComicsView extends Marionette.View
  behaviors: [HasHeader]
  ui:
    header: '.listview-header'
    prev_li: '.previous'
    next_li: '.next'
    prev_button: '.prev-page-button'
    next_button: '.next-page-button'
    entries: '.dbcomics-entries'
  regions:
    entries: '@ui.entries'
  events:
    'click @ui.prev_button': 'get_prev_page'
    'click @ui.next_button': 'get_next_page'
  template: tc.renderable () ->
    tc.div '.mytoolbar.row', ->
      tc.ul '.pager', ->
        tc.li '.previous', ->
          tc.i '.prev-page-button.fa.fa-arrow-left.btn.btn-default'
        tc.li '.next', ->
          tc.i '.next-page-button.fa.fa-arrow-right.btn.btn-default'
    tc.div '.listview-header'
    tc.div '.dbcomics-entries.row'
    
  keycommands:
    prev: 37
    next: 39
    
  handle_key_command: (command) ->
    if command in ['prev', 'next']
      @get_another_page command

  keydownHandler: (event_object) =>
    #console.log 'keydownHandler ' + event_object
    for key, value of @keycommands
      if event_object.keyCode == value
        @handle_key_command key

  onRender: ->
    entryTemplate = @options.entryTemplate or default_entry_template
    @collectionView = new DbComicEntryCollectionView
      collection: @collection
      entryTemplate: entryTemplate
    @showChildView 'entries', @collectionView
    @update_nav_buttons()
    @collection.on 'pageable:state:change', =>
      @update_nav_buttons()
    $('html').keydown @keydownHandler

  onBeforeDestroy: ->
    @collection.off 'pageable:state:change'
    $('html').unbind 'keydown', @keydownHandler
    
  update_nav_buttons: ->
    currentPage = @collection.state.currentPage
    console.log "currentPage", currentPage
    if currentPage
      @ui.prev_li.show()
    else
      console.log "currentPage should be zero", @ui.prev_li
      @ui.prev_li.hide()
    if currentPage != @collection.state.lastPage
      @ui.next_li.show()
    else
      @ui.next_li.hide()
    totalPages = @collection.state.totalPages
    if totalPages is null
      console.log "totalPages is null!!!!", @collection.state
      
    @triggerMethod 'set:header',
    "Page #{currentPage + 1} of #{@collection.state.totalPages}"
    
  onDomRefresh: ->
    @update_nav_buttons()

  get_another_page: (direction) ->
    currentPage = @collection.state.currentPage
    onLastPage = currentPage is @collection.state.lastPage
    if direction is 'prev' and currentPage
      @collection.getPreviousPage()
    else if direction is 'next' and not onLastPage
      @collection.getNextPage()
      
  get_prev_page: () ->
    @get_another_page 'prev'
  get_next_page: () ->
    @get_another_page 'next'

############################################
# Main view
############################################
class ComicsView extends Marionette.View
  templateContext: ->
    options = @options
    options
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "DbComics"
    tc.div '.body.col-sm-8.col-sm-offset-2'
  ui:
    body: '.body'
  regions:
    body: '@ui.body'
  onRender: ->
    view = new DbComicsView
      collection: @collection
    @showChildView 'body', view
    
      
    
module.exports = ComicsView


