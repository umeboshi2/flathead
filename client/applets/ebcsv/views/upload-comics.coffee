$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

class ProgressModel extends Backbone.Model
  defaults:
    valuemin: 0
    valuemax: 100
    valuenow: 0

class ProgressView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div '.progress.listview-list-entry', ->
      aria =
        valuemin: model.valuemin
        valuemax: model.valuemax
        valuenow: model.valuenow
      width = Math.floor model.valuenow / model.valuemax * 100 + 0.5
      tc.div '.progress-bar.progress-bar-striped.progress-bar-info',
      #role:'progressbar', aria: aria,
      role:'progressbar',
      style:"width: #{width}%"
  modelEvents:
    'change': 'render'
    
  
      
class UploadManager extends Marionette.Object
  channelName: 'ebcsv'
  initialize: (options) =>
    @modelName = options.modelName or 'clzcomic'
    @modelId = options.modelId or 'comic_id'
    @dbPrefix = "db:#{@modelName}"
    @collection = AppChannel.request "#{@dbPrefix}:collection"
    @curentItems = _.clone options.items
    @progressModel = options.progressModel
    @progressModel.set 'valuemax', @curentItems.length
    @channel = @getChannel()
    @channel.on "#{@dbPrefix}:inserted", @restore_items_now
    @channel.on "#{@dbPrefix}:updated", @restore_items_now
    console.log 'channel is', @channel
  insert_item: (item) ->
    if @collection.length
      throw new Error "We cannot insert!!!!"
    @channel.request "#{@dbPrefix}:add", item
  update_item: (item) ->
    if @collection.length != 1
      throw new Error "Not unique error!!!"
    model = @collection.models[0]
    @channel.request "#{@dbPrefix}:updatePassed", model, item
    
  restore_item: (item) ->
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
    position = @progressModel.get('valuemax') - @curentItems.length
    @progressModel.set 'valuenow', position
    if @curentItems.length
      item = @curentItems.pop()
      @restore_item item
    else
      MessageChannel.request 'success', "Restoration Successful"
      console.log "Stop Listening!!!!!!!!!!!!!!!!!!!!!!!"
      @channel.off "#{@dbPrefix}:inserted"
      @channel.off "#{@dbPrefix}:updated"
      @trigger "upload:completed"
      
  restore_items_now: =>
    #console.log "RESTORE_ITEMS_NOW!!!!!"
    @restore_items()
    

class UploadView extends Marionette.View
  regions:
    body: '.body'
    createProgress: '.create-progress'
    uploadProgress: '.upload-progress'
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "CLZ XML to EBay File Exchange CSV"
    tc.div '.create-progress'
    tc.div '.upload-progress'
    tc.div '.body'
  events:
    'item:created': 'create_items'
  initialize: (options) ->
    @comics = AppChannel.request 'get-comics'
    
    
  showUploadProgressBar: ->
    @uploadModel = new ProgressModel
    view = new ProgressView
      model: @uploadModel
    window.upmodel = @uploadModel
    @showChildView 'uploadProgress', view

  showCreateProgressBar: ->
    @createModel = new ProgressModel
    view = new ProgressView
      model: @createModel
    window.crmodel = @createModel
    @showChildView 'createProgress', view

  _createAttributes: (comic) ->
    attributes =
      comic_id: comic.id
      index: comic.index
      list_id: comic.collectionstatus.$.listid
      bpcomicid: comic.bpcomicid
      bpseriesid: comic.bpseriesid
      # FIXME
      rare: false
      publisher: comic.publisher.displayname
      releasedate: comic.releasedate.date
      seriesgroup: comic.seriesgroup.displayname
      series: comic.mainsection.series.displayname
      issue: comic.issue
      quantity: comic.quantity
      currentprice: comic.currentpricefloat
      content: comic
    url = comic?.links?.link?.url
    if url
      attributes.url = url
    return attributes
    
  createComicDbItem: (comic) ->
    attributes = @_createAttributes comic
    @currentItems.push attributes
    @createModel.set 'valuenow', @currentItems.length
    if @currentItems.length != @comics.length
      setTimeout =>
        @createAnotherItem()
      , 10
    else
      console.log "FINISHED CREATING"
      @uploadItems()
      
  createAnotherItem: ->
    if @comicClones.length
      comic = @comicClones.pop()
      @createComicDbItem comic
      
  createItems: ->
    comics = @comics
    clones = _.clone @comics
    @comicClones = clones.toJSON()
    @createModel.set 'valuemax', @comicClones.length
    @createModel.set 'valuenow', 0
    @currentItems = []
    comic = @comicClones.pop()
    @createComicDbItem comic

  uploadItems: ->
    @_mgr = new UploadManager
      modelName: 'clzcomic'
      items: @currentItems
      progressModel: @uploadModel
      modelId: 'comic_id'
    @_mgr.on 'upload:completed', @uploadCompleted
    @_mgr.restore_items()
    
  uploadCompleted: =>
    console.log "UPLOAD COMPLETED!!!!!!!!!!!!"
    delete @_mgr
    @currentItems = []
    @comicClones = undefined
    
  onRender: ->
    @showCreateProgressBar()
    @showUploadProgressBar()
    @createItems()
    
module.exports = UploadView


