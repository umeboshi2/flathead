$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'
dateFormat = require 'dateformat'
#require('editable-table/mindmup-editabletable')

DbComicEntry = require './dbcomic-entry'
DbComicsSidebar = require './dbcomics-sidebar'
HasHeader = require './has-header'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

default_entry_template = tc.renderable (model) ->
  tc.div "default_entry_template"

dbComicColumns = AppChannel.request 'dbComicColumns'

sortbyInput = tc.renderable (sortColumn) ->
  default_sort = ['seriesgroup', 'series', 'issue']
  tc.span '.input-group', ->
    tc.label '.control-label', for:'select_sortby', 'Sort by'
    tc.select '.form-control', name:'select_sortby', ->
      opts =
        value: 'default'
      if sortColumn is default_sort
        opts.selected = ''
      tc.option opts, 'default'
      for col in dbComicColumns
        opts =
          value: col
        if sortColumn is col
          opts.selected = ''
        tc.option opts, col
            

class DbComicEntryCollectionView extends Marionette.NextCollectionView
  childView: DbComicEntry

class DbComicsViewOrig extends Marionette.View
  behaviors: [HasHeader]
  ui:
    header: '.listview-header'
    prev_li: '.previous'
    next_li: '.next'
    prev_button: '.prev-page-button'
    next_button: '.next-page-button'
    entries: '.dbcomics-entries'
    sort_by: '.sortby select'
  regions:
    entries: '@ui.entries'
  events:
    'click @ui.prev_button': 'get_prev_page'
    'click @ui.next_button': 'get_next_page'
    'change @ui.sort_by': 'sort_collection'
  templateContext: ->
    collection: @collection
  template: tc.renderable (model) ->
    tc.div '.mytoolbar.row', ->
      tc.ul '.pager', ->
        tc.li '.previous', ->
          tc.i '.prev-page-button.fa.fa-arrow-left.btn.btn-default'
        tc.li '.next', ->
          tc.i '.next-page-button.fa.fa-arrow-right.btn.btn-default'
        tc.li '.sortby', ->
          sortbyInput model.collection.state.sortColumn
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
    totalRecords = @collection.state.totalRecords
    
    @triggerMethod 'set:header',
    "Page #{currentPage + 1} of #{totalPages} (#{totalRecords} comics total)"
    
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

  sort_collection: ->
    sort = @ui.sort_by.val()
    console.log "sort collection", sort
    state =
      sortColumn: sort
      currentPage: 0
    @collection.state.sortColumn = sort
    @collection.state.currentPage = 0
    response = @collection.fetch()
    #response.done =>
    #  @render()
      

class DbComicsView extends Marionette.View
  behaviors: [HasHeader]
  ui:
    header: '.listview-header'
    entries: '.dbcomics-entries'
  regions:
    entries: '@ui.entries'
  template: tc.renderable (model) ->
    tc.div '.listview-header'
    tc.div '.dbcomics-entries.row'
    
  updateHeader: ->
    currentPage = @collection.state.currentPage
    totalPages = @collection.state.totalPages
    totalRecords = @collection.state.totalRecords
    
    @triggerMethod 'set:header',
    "Page #{currentPage + 1} of #{totalPages} (#{totalRecords} comics total)"
    
  onRender: ->
    entryTemplate = @options.entryTemplate or default_entry_template
    @collectionView = new DbComicEntryCollectionView
      collection: @collection
      entryTemplate: entryTemplate
    @showChildView 'entries', @collectionView
    @updateHeader()
    @collection.on 'pageable:state:change', =>
      @updateHeader()
    
  onBeforeDestroy: ->
    @collection.off 'pageable:state:change'


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
    tc.div '.row', ->
      tc.div '.sidebar.col-sm-3.col-sm-offset-1'
      tc.div '.body.col-sm-7'
  ui:
    body: '.body'
    sidebar: '.sidebar'
  regions:
    body: '@ui.body'
    sidebar: '@ui.sidebar'
  onRender: ->
    sidebar = new DbComicsSidebar
      collection: @collection
    @showChildView 'sidebar', sidebar
    view = new DbComicsView
      collection: @collection
    @showChildView 'body', view
    
      
    
module.exports = ComicsView


