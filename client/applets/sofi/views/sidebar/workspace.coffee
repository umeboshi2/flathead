$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

{ form_group_input_div } = require 'tbirds/templates/forms'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

AuthCollection = MainChannel.request 'main:app:AuthCollection'
apiroot = "/api/dev/bapi"
class WorkspaceCollection extends AuthCollection
  url: "#{apiroot}/ebcomicworkspace"
  model: AppChannel.request 'db:clzcomic:modelClass'
  state:
    firstPage: 0
    # FIXME
    pageSize: 10000
    sortColumn: 'name'
    sortDirection: 'asc'
    
class DbComicsSidebar extends Marionette.View
class WorkspaceView extends Marionette.View
  className: 'listview-list-entry'
  ui:
    name_input: 'input[name="name"]'
  templateContext: ->
    collection: @collection
  template: tc.renderable (model) ->
    form_group_input_div
      input_id: "input_wsname"
      label: 'Workspace Name'
      input_attributes:
        name: "name"
    tc.span '.input-group', ->
      tc.label '.control-label', for:'select_workspace',
      'Workspace'
      tc.select '.form-control', name:'select_workspace', ->
        if not model.items.length
          tc.option value:'current', selected:'', 'Current'
        else
          for item in model.items
            opts = value: item.name
            tc.option opts, item.name
      
module.exports = WorkspaceView
