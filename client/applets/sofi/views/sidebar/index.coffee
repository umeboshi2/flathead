$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'
dateFormat = require 'dateformat'
#require('editable-table/mindmup-editabletable')

DbComicEntry = require '../dbcomic-entry'
HasHeader = require '../has-header'
SeriesGroupSelect = require './seriesgroup'
PublisherSelect = require './publisher'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

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
    where = AppChannel.request 'locals:get', 'currentQueryWhere'
    if collectionStatus is 'ALL'
      delete where.list_id
    else
      where.list_id = collectionStatus
    AppChannel.request 'locals:set', 'currentQueryWhere', where
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
        where: AppChannel.request 'locals:get', 'currentQueryWhere'
    response.done =>
      @collection.trigger 'pageable:state:change'

AuthCollection = MainChannel.request 'main:app:AuthCollection'
apiroot = "/api/dev/bapi"
class SeriesGroupCollection extends AuthCollection
  url: "#{apiroot}/ebclzcomic"
  model: AppChannel.request 'db:clzcomic:modelClass'
  state:
    firstPage: 0
    # FIXME
    pageSize: 10000
    sortColumn: 'seriesgroup'
    sortDirection: 'asc'
  
class PublisherCollection extends AuthCollection
  url: "#{apiroot}/ebclzcomic"
  model: AppChannel.request 'db:clzcomic:modelClass'
  state:
    firstPage: 0
    # FIXME
    pageSize: 10000
    sortColumn: 'publisher'
    sortDirection: 'asc'
  
class WorkspaceDrop extends Marionette.View
  events:
    'dragover': 'handle_dragOver'
    'dragenter': 'handle_dragEnter'
    'drop': 'handle_drop'
  templateContext: ->
    collection: @collection
  template: tc.renderable (model) ->
    tc.div 'workspace'
    
  handle_drop: (event) ->
    event.preventDefault()
    @$el.css 'border', '0px'
    console.log "event", event
    dt = event.originalEvent.dataTransfer
    console.log 'dt', dt
    
  handle_dragOver: (event) ->
    event.preventDefault()
    event.stopPropagation()
    
  handle_dragEnter: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @$el.css 'border', '2px dotted'

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
    publisherFilterBox: '.publisher-filter-box'
    seriesgroupFilterBox: '.seriesgroup-filter-box'
    workspaceDrop: '.workspace-drop'
  regions:
    sortByBox: '@ui.sortByBox'
    collectionStatusFilterBox: '@ui.collectionStatusFilterBox'
    seriesgroupFilterBox: '@ui.seriesgroupFilterBox'
    publisherFilterBox: '@ui.publisherFilterBox'
    workspaceDrop: '@ui.workspaceDrop'
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
    tc.div '.publisher-filter-box.listview-list-entry'
    tc.div '.seriesgroup-filter-box.listview-list-entry'
    tc.div '.workspace-drop.listview-list-entry'
    
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
    response = @collection.fetch
      data:
        where: AppChannel.request 'locals:get', 'currentQueryWhere'
    response.done =>
      @collection.trigger 'pageable:state:change'

  showCollectionStatus: ->
    selections = AppChannel.request 'db:clzcollectionstatus:collection'
    response = selections.fetch()
    response.done =>
      view = new CollectionStatusSelect
        collection: selections
        comicCollection: @collection
      @showChildView 'collectionStatusFilterBox', view
  showSeriesGroupSelect: ->
    coll = new SeriesGroupCollection
    response = coll.fetch
      data:
        distinct: 'seriesgroup'
        sort: 'seriesgroup'
    response.done =>
      view = new SeriesGroupSelect
        collection: coll
        comicCollection: @collection
      @showChildView 'seriesgroupFilterBox', view
      window.sgview = view
  showPublisherSelect: ->
    coll = new PublisherCollection
    response = coll.fetch
      data:
        distinct: 'publisher'
        sort: 'publisher'
    response.done =>
      view = new PublisherSelect
        collection: coll
        comicCollection: @collection
      @showChildView 'publisherFilterBox', view
  showSortBySelect: ->
    sortbyview = new SortBySelect
      collection: @collection
    @showChildView 'sortByBox', sortbyview
  showWorkspaceBox: ->
    wsview = new WorkspaceDrop
    @showChildView 'workspaceDrop', wsview
    
  onRender: ->
    # show child views
    @showCollectionStatus()
    @showPublisherSelect()
    @showSeriesGroupSelect()
    @showSortBySelect()
    @showWorkspaceBox()
    # do setup
    @update_nav_buttons()
    @collection.on 'pageable:state:change', =>
      @update_nav_buttons()
    $('html').keydown @keydownHandler
    
  onBeforeDestroy: ->
    @collection.off 'pageable:state:change'
    $('html').unbind 'keydown', @keydownHandler

  get_another_page: (direction) ->
    # we need to add the where clause
    where = AppChannel.request 'locals:get', 'currentQueryWhere'
    @collection.queryParams.where = where
    currentPage = @collection.state.currentPage
    onLastPage = currentPage is @collection.state.lastPage
    response = undefined
    if direction is 'prev' and currentPage
      response = @collection.getPreviousPage()
    else if direction is 'next' and not onLastPage
      response = @collection.getNextPage()
    if response
      response.done =>
        # remove the where clause when done
        delete @collection.queryParams.where
    
  get_prev_page: () ->
    @get_another_page 'prev'
  get_next_page: () ->
    @get_another_page 'next'
      
    
module.exports = DbComicsSidebar


