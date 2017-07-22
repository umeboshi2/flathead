$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'
dateFormat = require 'dateformat'
#require('editable-table/mindmup-editabletable')
require 'jquery-ui/ui/widgets/droppable'

DbComicEntry = require './dbcomic-entry'
DbComicsSidebar = require './sidebar'
HasHeader = require './has-header'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

default_entry_template = tc.renderable (model) ->
  tc.div "default_entry_template"

dbComicColumns = AppChannel.request 'dbComicColumns'

class DbComicEntryCollectionView extends Marionette.NextCollectionView
  childView: DbComicEntry
  childViewOptions:
    workspaceView: true
  # bubble event up to workspaceView
  childViewTriggers:
    'workspace:add:comic': 'workspace:add:comic'

directionLabel =
  asc: 'ascending'
  desc: 'descending'

AuthCollection = MainChannel.request 'main:app:AuthCollection'
class UnattachedCollection extends AuthCollection
  url: "/api/dev/misc/unattached-comics"
  
uc = new UnattachedCollection
window.uc = uc

class WorkspaceView extends Marionette.View
  behaviors: [HasHeader]
  ui:
    header: '.listview-header'
    entries: '.dbcomics-entries'
  regions:
    entries: '@ui.entries'
  template: tc.renderable (model) ->
    tc.div '.listview-header'
    tc.div '.dbcomics-entries.row'
  # bubble event up to main view
  childViewTriggers:
    'workspace:add:comic': 'workspace:add:comic'
    
  updateHeader: ->
    state = @collection.state
    totalRecords = state.totalRecords
    unless totalRecords is null
      currentPage = state.currentPage
      totalPages = state.totalPages
      direction = directionLabel[state.sortDirection]
      msg = "Page #{currentPage + 1} of #{totalPages}, #{direction}"
      msg = msg + " pages, with #{totalRecords} comics total."
      @triggerMethod 'set:header', msg
    else
      msg = "No comics in workspace"
      @triggerMethod 'set:header', msg
      
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
class MainView extends Marionette.View
  initialize: (options) ->
    options = options or {}
    cclass = AppChannel.request 'db:ebcomicworkspace:collectionClass'
    console.log "cclass", cclass
    options.collection = options?.collection or new cclass
    console.log "options.collection", options.collection
  templateContext: ->
    options = @options
    options
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "Workspace"
    tc.div '.row', ->
      tc.div '.sidebar.col-sm-4', style:'height: calc(100% - 50px);'
      tc.div '.body.col-sm-8'
  ui:
    body: '.body'
    sidebar: '.sidebar'
  regions:
    body: '@ui.body'
    sidebar: '@ui.sidebar'
  childViewEvents:
    'workspace:add:comic': 'onWorkspaceAddComic'
    'workspace:changed': 'onWorkspaceChanged'
    
  onWorkspaceAddComic: (comic_id) ->
    console.log "onWorkspaceAddComic", comic_id
    sidebar = @getChildView 'sidebar'
    console.log "SIDEBAR", sidebar
    workspaceDrop = sidebar.getChildView 'workspaceDrop'
    workspace = workspaceDrop.ui.name_input.val() or 'current'
    console.log 'workspaceDrop', workspace
    MessageChannel.request 'warning', "addToWorkspace #{comic_id} #{workspace}"
    collection = AppChannel.request 'db:ebcomicworkspace:collection'
    collection.on 'add', =>
      MessageChannel.request "warning",
      "It should have been added to collection."
      collection.off 'add'
    data =
      comic_id: comic_id
      name: workspace
    model = collection.create data, wait:true

  onWorkspaceChanged: (view) ->
    workspace = view.ui.name_input.val()
    console.log "onWorkspaceChanged", workspace
    unless workspace is 'UNATTACHED'
      collection = @getOption 'collection'
      response = collection.fetch
        data:
          where:
            name: workspace
        
  onRender: ->
    collection = @getOption 'collection'
    sidebar = new DbComicsSidebar
      collection: collection
      workspaceSidebar: true
    @showChildView 'sidebar', sidebar
    view = new WorkspaceView
      collection: collection
    @showChildView 'body', view
    
      
    
module.exports = MainView


