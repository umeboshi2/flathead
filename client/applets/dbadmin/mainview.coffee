$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
dateFormat = require 'dateformat'
# FIXME this makes global YAML
yaml = require 'yamljs/dist/yaml'

{ modal_close_button } = require 'tbirds/templates/buttons'
navigate_to_url = require 'tbirds/util/navigate-to-url'
capitalize = require 'tbirds/util/capitalize'
IsEscapeModal = require 'tbirds/behaviors/is-escape-modal'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'dbadmin'


ConfirmDeleteTemplate = tc.renderable (model) ->
  mtype = model.modelType
  console.log 'mtype', mtype
  tc.div '.modal-dialog', ->
    tc.div '.modal-content', ->
      tc.h3 "Do you really want to delete all #{capitalize mtype}s?"
      tc.div '.modal-body', ->
        tc.div '#selected-children'
      tc.div '.modal-footer', ->
        tc.ul '.list-inline', ->
          btnclass = 'btn.btn-default.btn-sm'
          tc.li "#confirm-delete-button", ->
            modal_close_button 'OK', 'check'
          tc.li "#cancel-delete-button", ->
            modal_close_button 'Cancel'

class ConfirmDeleteModal extends Marionette.View
  behaviors: [IsEscapeModal]
  template: ConfirmDeleteTemplate
  ui: ->
    # close_btn is for IsEscapeModal
    close_btn = '#cancel-delete-button'
    confirm_delete: '#confirm-delete-button'
    cancel_button: close_btn
    close_btn: close_btn
  events: ->
    'click @ui.confirm_delete': 'really_delete_items'
    
  really_delete_items: ->
    # FIXME -- this is poor!
    #@collection.forEach (model) ->
    promises = []
    while model = @collection.first()
      console.log "delete model!!!!", model
      promises.push model.destroy()
    # https://stackoverflow.com/a/5627301
    $.when.apply($, promises).then ->
      MessageChannel.request 'success', 'Items Deleted!'
      #navigate_to_url '#dbadmin'
      applet = MainChannel.request 'main:applet:get-applet', 'dbadmin'
      applet.router.controller.mainview()
      
simple_template = tc.renderable (model) ->
  count = model.items.length
  tc.div '.listview-list-entry', ->
    tc.div "There are #{count} #{model.modelType}s."
    if count
      tc.button ".backup-button.btn.btn-default", "Backup"
    tc.label '.restore-label.btn.btn-default.btn-file', ->
      tc.span 'restore '
      tc.input '.restore-button.input', type:'file', style: 'display:none'
    tc.button '.upload-button.btn.btn-default', style: 'display:none'
    if count
      tc.button ".delete-button.btn.btn-default", "Delete"

mtypeCollectionMap =
  config: 'ebcfg'
  description: 'ebdsc'
  todo: 'todo'

strip_id = (attributes) ->
  if attributes?.id
    delete attributes.id

must_have_one = (collection) ->
  if collection.length != 1
    throw new Error "Not unique error!!!"

must_have_zero = (collection) ->
  if collection.length
    throw new Error "We cannot insert!!!!"
      
class RestorationManager extends Marionette.Object
  channelName: 'dbadmin'
  initialize: (options) ->
    @modelName = options.type
    @dbPrefix = "db:#{mtypeCollectionMap[options.type]}"
    @collection = AppChannel.request "#{@dbPrefix}:collection"
    @curentItems = _.clone options.items
    #console.log "initialize @curentItems", @curentItems
    @channel = @getChannel()
    @channel.on "#{@dbPrefix}:inserted", @restore_items
    @channel.on "#{@dbPrefix}:updated", @restore_items
    @modelId = options.modelId or 'name'

  insert_item: (item) ->
    #console.log 'insert_item', item
    strip_id item
    must_have_zero @collection
    #console.log "@channel", @channel
    @channel.request "#{@dbPrefix}:add", item
  
  update_item: (item) ->
    #console.log 'update_item', item
    strip_id item
    must_have_one @collection
    model = @collection.models[0]
    @channel.request "#{@dbPrefix}:updatePassed", model, item
    
  restore_item: (item) ->
    #console.log "restore_item", item
    # reset collection to help check for multiples
    @collection.reset()
    response = @collection.fetch
      data:
        where:
          "#{@modelId}": item[@modelId]
    response.fail ->
      msg = "There was a problem talking to the server"
      MessageChannel.request 'warning', msg
    response.done =>
      if @collection.length > 1
        MessageChannel.request 'warning', "#{name} is not unique!"
      if not @collection.length
        @insert_item item
      else
        @update_item item
      
  restore_items: =>
    #console.log "restore_items @curentItems", @curentItems
    if @curentItems.length
      item = @curentItems.pop()
      @restore_item item
    else
      MessageChannel.request 'success', "Restoration Successful"
      applet = MainChannel.request 'main:applet:get-applet', 'dbadmin'
      applet.router.controller.mainview()
      
restore_data = (data) ->
  mgr = new RestorationManager data
  mgr.restore_items()
    
class SimpleMgr extends Marionette.View
  template: simple_template
  templateContext: ->
    modelType: @getOption 'modelType'
  ui:
    backup_btn: '.backup-button'
    delete_btn: '.delete-button'
    restore_btn: '.restore-button'
    restore_lbl: '.restore-label'
    upload_btn: '.upload-button'
    
  events:
    'click @ui.backup_btn': 'backup_items'
    'click @ui.delete_btn': 'delete_items'
    'click @ui.upload_btn': 'upload_items'
    'change @ui.restore_btn': 'restore_changed'
  backup_items: ->
    #msg = "Backup #{capitalize @templateContext.modelType}s not implemented"
    #MessageChannel.request 'warning', msg
    #items = @collection.toJSON()
    @make_yaml_file()
    
  make_yaml_file: ->
    data =
      type: @getOption 'modelType'
      items: @collection.toJSON()
    now = new Date()
    sformat = "mmddHHMM"
    timestring = dateFormat now, sformat
    filename = "#{data.type}-#{timestring}.yaml"
    options =
      type: 'data:text/yaml;charset=utf-8'
      data: YAML.stringify data
      el_id: 'exported-file-anchor'
      filename: filename
    MainChannel.request 'export-to-file', options
    
  delete_items: ->
    view = new ConfirmDeleteModal
      collection: @collection
      templateContext:
        modelType: @getOption 'modelType'
    MainChannel.request 'show-modal', view
  restore_changed: (event) ->
    #@ui.restore_btn.show()
    @ui.restore_btn.hide()
    @ui.upload_btn.show()
    @ui.restore_lbl.hide()
    @ui.restore_lbl.removeClass('btn btn-default')
    #console.log 'restore_changed', event
    fname = event.target.files[0].name
    #fname = @ui.restore_btn.val()
    @ui.upload_btn.text "Upload #{fname}"

  upload_items: ->
    file = @ui.restore_btn[0].files[0]
    reader = new FileReader()
    reader.onload = @yamlReaderOnLoad
    reader.readAsText file

  yamlReaderOnLoad: (event) =>
    content = event.target.result
    data = YAML.parse content
    mtype = @templateContext.modelType
    if data?.type
      if data.type != @getOption 'modelType'
        MessageChannel.request 'warning', "Wrong type of file!"
        @reset_restore_button()
      else:
        #console.log "ok"
        restore_data data
    else
      @reset_restore_button()
      

  reset_restore_button: ->
    @ui.restore_btn.hide()
    @ui.restore_lbl.show()
    @ui.restore_lbl.addClass('btn btn-default')
    @ui.restore_lbl.val ''
    @ui.upload_btn.hide()
    
  successfulParse: =>
    @ui.status_msg.text "Parse Successful"
    if __DEV__
      window.comics = AppChannel.request 'get-comics'
    navigate_to_url "#dbadmin"
    
class EbCfgMgr extends SimpleMgr
  templateContext:
    modelType: 'config'

class EbDscMgr extends SimpleMgr
  templateContext:
    modelType: 'description'
    
class MainView extends Marionette.View
  regions:
    config: '.cfg-container'
    description: '.dsc-container'
    todo: '.todo-container'
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "Database Management"
    tc.div '.cfg-container'
    tc.div '.dsc-container'
    tc.div '.todo-container'
  renderItems: (mtype, ctype) ->
    collection = AppChannel.request "db:#{ctype}:collection"
    response = collection.fetch()
    response.done =>
      view = new SimpleMgr
        modelType: mtype
        collection: collection
      @showChildView mtype, view
    response.fail ->
      MessageChannel.request 'danger', "Failed to get #{mtype}s."
  
  onRender: ->
    @renderItems 'config', 'ebcfg'
    @renderItems 'description', 'ebdsc'
    @renderItems 'todo', 'todo'
      

module.exports = MainView

