_ = require 'underscore'
Backbone = require 'backbone'

BootstrapFormView = require 'tbirds/views/bsformview'

make_field_input_ui = require 'tbirds/util/make-field-input-ui'
navigate_to_url = require 'tbirds/util/navigate-to-url'
HasAceEditor = require 'tbirds/behaviors/ace'

tc = require 'teacup'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

EditForm = tc.renderable (model) ->
  tc.div '.listview-header', 'Document'
  for field in ['name', 'title']
    make_field_input(field)(model)
  tc.div '#ace-editor', style:'position:relative;width:100%;height:40em;'
  tc.input '.btn.btn-default', type:'submit', value:"Submit"
  tc.div '.spinner.fa.fa-spinner.fa-spin'
  

class BaseFormView extends BootstrapFormView
  editorMode: 'markdown'
  editorContainer: 'ace-editor'
  fieldList: ['name', 'title']
  template: EditForm
  ui: ->
    uiobject = make_field_input_ui @fieldList
    _.extend uiobject, {'editor': '#ace-editor'}
    return uiobject
  
  behaviors:
    HasAceEditor:
      behaviorClass: HasAceEditor
      
  afterDomRefresh: () ->
    if @model.has 'content'
      content = @model.get 'content'
      @editor.setValue content

  updateModel: ->
    for field in @fieldList
      @model.set field, @ui[field].val()
    # update from ace-editor
    @model.set 'content', @editor.getValue()

  onSuccess: (model) ->
    name = @model.get 'name'
    MessageChannel.request 'success', "#{name} saved successfully."
    
    
class NewFormView extends BaseFormView
  createModel: ->
    AppChannel.request 'new-ebdsc'

  saveModel: ->
    collection = AppChannel.request 'ebdsc-collection'
    collection.add @model
    super
    
  onSuccess: (model) ->
    navigate_to_url "#ebcsv/dsc/view/#{model.id}"
    

class EditFormView extends BaseFormView
  # the model should be assigned in the controller
  createModel: ->
    @model
    
module.exports =
  NewFormView: NewFormView
  EditFormView: EditFormView
  

