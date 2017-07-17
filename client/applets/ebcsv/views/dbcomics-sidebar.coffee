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

dbComicColumns = AppChannel.request 'dbComicColumns'
defaultComicSort = ['seriesgroup', 'series', 'issue']

sortbyInput = tc.renderable (sortColumn) ->
  tc.span '.input-group', ->
    tc.label '.control-label', for:'select_sortby', 'Sort by'
    tc.select '.form-control', name:'select_sortby', ->
      opts =
        value: 'default'
      if sortColumn is defaultComicSort
        opts.selected = ''
      tc.option opts, 'default'
      for col in dbComicColumns
        opts =
          value: col
        if sortColumn is col
          opts.selected = ''
        tc.option opts, col
            
class DbComicsSidebar extends Marionette.View
  ui:
    prev_li: '.previous'
    next_li: '.next'
    prev_button: '.prev-page-button'
    next_button: '.next-page-button'
    sort_by: 'select[name="select_sortby"]'
    forsale_cbox: '.forsale-cbox'
  templateContext: ->
    collection: @collection
  template: tc.renderable (model) ->
    sortColumn = model.collection.state.sortColumn
    tc.ul '.pager', ->
      tc.li '.previous', ->
        tc.span '.prev-page-button.btn.btn-default', ->
          tc.i '.fa.fa-arrow-left'
          tc.text '-previous'
      tc.li '.next', ->
        tc.span '.next-page-button.btn.btn-default', ->
          tc.text 'next-'
          tc.i '.fa.fa-arrow-right'
    sortbyInput sortColumn
    tc.div '.checkbox', ->
      tc.label ->
        tc.input '.forsale-cbox.checkbox', type:'checkbox'
        tc.text  "only for sale."
  events:
    'click @ui.prev_button': 'get_prev_page'
    'click @ui.next_button': 'get_next_page'
    'change @ui.sort_by': 'sort_collection'
    'change @ui.forsale_cbox': 'forsale_changed'
  update_nav_buttons: ->
    currentPage = @collection.state.currentPage
    if currentPage
      @ui.prev_li.show()
    else
      @ui.prev_li.hide()
    if currentPage != @collection.state.lastPage
      @ui.next_li.show()
    else
      @ui.next_li.hide()
    totalPages = @collection.state.totalPages
    totalRecords = @collection.state.totalRecords
    
  sort_collection: ->
    sort = @ui.sort_by.val()
    console.log "sort collection", sort
    if sort is 'default'
      sort = defaultComicSort
    state =
      sortColumn: sort
      currentPage: 0
    @collection.state.sortColumn = sort
    @collection.state.currentPage = 0
    #response = @collection.fetch()
    #response.done =>
    @collection.getFirstPage()

  forsale_changed: (event) ->
    console.log "forsale_changed", event.target
    console.log "forsale_changed val", @ui.forsale_cbox
    window.cbox = @ui.forsale_cbox
    if @ui.forsale_cbox.is ':checked'
      response = @collection.fetch
        data:
          where:
            list_id: 4
      response.done =>
        @collection.getFirstPage()
    else
      response = @collection.fetch()
      response.done =>
        @collection.getFirstPage()
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
    @update_nav_buttons()
    @collection.on 'pageable:state:change', =>
      @update_nav_buttons()
    $('html').keydown @keydownHandler
    
  onBeforeDestroy: ->
    @collection.off 'pageable:state:change'
    $('html').unbind 'keydown', @keydownHandler
    
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
      
    
module.exports = DbComicsSidebar


