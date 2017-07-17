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

currentQueryWhere = {}


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

class CollectionStatusSelect extends Marionette.View
  ui:
    collectionStatus: 'select[name="select_collectionstatus"]'
  events:
    'change @ui.collectionStatus': 'selectionChanged'
  templateContext: ->
    collection: @collection
  template: tc.renderable (model) ->
    tc.span '.input-group', ->
      tc.label '.control-label', for:'select_collectionstatus',
      'Collection Status'
      tc.select '.form-control', name:'select_collectionstatus', ->
        tc.option value:'ALL', selected:'', 'All Status'
        for item in model.items
          opts =
            value: item.id
          tc.option opts, item.name
  selectionChanged: (event) ->
    collectionStatus = @ui.collectionStatus.val()
    comicCollection = @getOption 'comicCollection'
    where = currentQueryWhere
    if collectionStatus is 'ALL'
      delete where.list_id
    else
      where.list_id = collectionStatus
    currentQueryWhere = where
    response = comicCollection.fetch
      data:
        where: where
    response.done ->
      comicCollection.state.currentPage = 0
      comicCollection.trigger 'pageable:state:change'
      
class SortBySelect extends Marionette.View
  ui:
    sort_by: 'select[name="select_sortby"]'
  events:
    'change @ui.sort_by': 'sort_collection'
  templateContext: ->
    collection: @collection
  template: tc.renderable (model) ->
    sortColumn = model.collection.state.sortColumn
    sortbyInput sortColumn
  sort_collection: ->
    sort = @ui.sort_by.val()
    if sort is 'default'
      sort = defaultComicSort
    @collection.state.sortColumn = sort
    @collection.state.currentPage = 0
    response = @collection.fetch
      data:
        where: currentQueryWhere
    response.done =>
      @collection.trigger 'pageable:state:change'
    #response.done =>
    #  @collection.getFirstPage()

    
class DbComicsSidebar extends Marionette.View
  ui:
    prev_li: '.previous'
    next_li: '.next'
    prev_button: '.prev-page-button'
    dir_button: '.direction-button'
    dir_icon: '.direction-icon'
    next_button: '.next-page-button'
    sortByBox: '.sort-by-box'
    collectionStatusFilterBox: '.collection-status-filter-box'
  regions:
    sortByBox: '@ui.sortByBox'
    collectionStatusFilterBox: '@ui.collectionStatusFilterBox'
  templateContext: ->
    collection: @collection
  template: tc.renderable (model) ->
    sortColumn = model.collection.state.sortColumn
    tc.ul '.pager.listview-list-entry', ->
      tc.li '.previous', ->
        # just .btn changes cursor to pointer
        tc.span '.prev-page-button.btn', ->
          tc.i '.fa.fa-arrow-left'
          tc.text '-previous'
      tc.li '.direction', ->
        tc.span '.direction-button.btn', ->
          tc.i '.direction-icon.fa.fa-arrow-up'
      tc.li '.next', ->
        tc.span '.next-page-button.btn', ->
          tc.text 'next-'
          tc.i '.fa.fa-arrow-right'
    tc.div '.sort-by-box.listview-list-entry'
    tc.div '.collection-status-filter-box.listview-list-entry'
  events:
    'click @ui.prev_button': 'get_prev_page'
    'click @ui.dir_button': 'toggle_sort_direction'
    'click @ui.next_button': 'get_next_page'
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
    if @collection.state.totalRecords is 0
      @ui.prev_li.hide()
      @ui.next_li.hide()
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

  toggle_sort_direction: (event) ->
    icon = @ui.dir_icon
    if icon.hasClass 'fa-arrow-up'
      icon.removeClass 'fa-arrow-up'
      icon.addClass 'fa-arrow-down'
      @collection.state.sortDirection = 'desc'
    else
      icon.removeClass 'fa-arrow-down'
      icon.addClass 'fa-arrow-up'
      @collection.state.sortDirection = 'asc'
    console.log "toggle_sort_direction", @collection
    response = @collection.fetch
      data:
        where: currentQueryWhere
    response.done =>
      @collection.trigger 'pageable:state:change'
    
  onRender: ->
    selections = AppChannel.request 'db:clzcollectionstatus:collection'
    response = selections.fetch()
    response.done =>
      view = new CollectionStatusSelect
        collection: selections
        comicCollection: @collection
      @showChildView 'collectionStatusFilterBox', view
    view = new SortBySelect
      collection: @collection
    @showChildView 'sortByBox', view
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


