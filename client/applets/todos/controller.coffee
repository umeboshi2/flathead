Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ MainController } = require 'tbirds/controllers'
{ ToolbarAppletLayout } = require 'tbirds/views/layout'
navigate_to_url = require 'tbirds/util/navigate-to-url'
scroll_top_fast = require 'tbirds/util/scroll-top-fast'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'todos'

toolbarEntries = [
  {
    button: '#list-todos-button'
    label: 'List'
    url: '#todos'
    icon: '.fa.fa-list'
  }
  {
    button: '#calendar-button'
    label: 'Calendar'
    url: '#todos/calendar'
    icon: '.fa.fa-calendar'
  }
  {
    button: '#list-todos-completed-button'
    label: 'Completed'
    url: '#todos/completed'
    icon: '.fa.fa-list'
  }
  ]

class ToolbarEntryView extends Marionette.View
  attributes: ->
    id: @model.get 'button'
    'class': 'btn btn-default'
  template: tc.renderable (model) ->
    tc.i model.icon, model.label
  ui: ->
    button: @model.get 'button'
  events:
    'click @ui.button': 'buttonClicked'
  buttonClicked: ->
    navigate_to_url @model.get 'url'

class ToolbarEntryCollectionView extends Marionette.CollectionView
  childView: ToolbarEntryView
  className: 'btn-group btn-group-justified'

class ToolbarView extends Marionette.View
  template: tc.renderable () ->
    tc.div '.toolbar-entries'
  regions:
    entries:
      el: '.toolbar-entries'
      #replaceElement: true
  onRender: =>
    view = new ToolbarEntryCollectionView
      collection: new Backbone.Collection toolbarEntries
    @showChildView 'entries', view
  
# FIXME use a better name
rbool =
  true: 1
  false: 0
  

class Controller extends MainController
  layoutClass: ToolbarAppletLayout
  collection: AppChannel.request 'todo-collection'
  setup_layout_if_needed: ->
    super()
    @layout.showChildView 'toolbar', new ToolbarView

  _load_view: (vclass, model, objname) ->
    # FIXME
    # presume "id" is only attribute there if length is 1
    #if model.isEmpty() or Object.keys(model.attributes).length is 1
    if model.isEmpty() or not model.has 'created_at'
      response = model.fetch()
      response.done =>
        @_show_view vclass, model
      response.fail =>
        msg = "Failed to load #{objname} data."
        MessageChannel.request 'danger', msg
    else
      @_show_view vclass, model
    
  
  list_certain_todos: (completed) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      ListView = require './views/todolist'
      view = new ListView
        collection: @collection
      response = @collection.fetch
        data:
          completed: completed
      response.done =>
        @_show_content view
      response.fail =>
        MessageChannel.request 'danger', "Failed to load todos."
    # name the chunk
    , 'todos-list-todos'

  list_completed_todos: () ->
    # FIXME - fix rest inferface to use booleans
    @list_certain_todos rbool.true

  list_todos: () ->
    # FIXME - fix rest inferface to use booleans
    @list_certain_todos rbool.false

  new_todo: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { NewView } = require './views/editor'
      @_show_content new NewView
    # name the chunk
    , 'todos-new-todo'

  edit_todo: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { EditView } = require './views/editor'
      model = AppChannel.request 'get-todo', id
      @_load_view EditView, model, 'todo'
    # name the chunk
    , 'todos-edit-todo'
      
  view_todo: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      MainView = require './views/viewtodo'
      model = AppChannel.request 'get-todo', id
      @_load_view MainView, model, 'todo'
    # name the chunk
    , 'todos-view-todo'
      
  view_calendar: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/todocal'
      @layout.showChildView 'content', new View
    # name the chunk
    , 'todos-view-calendar'
      
      
module.exports = Controller

