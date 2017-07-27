Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

fileinput = require 'bootstrap-fileinput'
require 'bootstrap-fileinput/css/fileinput.css'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'
  
apiroot = '/api/dev/misc'

BootstrapFormView = require 'tbirds/views/bsformview'
navigate_to_url = require 'tbirds/util/navigate-to-url'
{ form_group_input_div } = require 'tbirds/templates/forms'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'

makePhotosObject = require '../ebutils/make-photos-object'


class PhotosView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div '.row', ->
      for p in model.photos
        tc.div '.listview-list-entry.col-sm-2', ->
          tc.div '.listview-header', p.name
          tc.img '.img-responsive.img-thumbnail', src:"/thumbs/#{p.filename}"
  
class FileInputView extends Marionette.View
  template: tc.renderable (model) ->
    tc.input '.fileinput', name:'comicphoto', type:'file'
  ui:
    fileinput: '.fileinput'
  onDomRefresh: ->
    comic_id = @model.get 'comic_id'
    fi = @ui.fileinput.fileinput
      uploadUrl: "#{apiroot}/upload-photo"
      uploadExtraData:
        comic_id: comic_id
        name: @getOption 'photoName'
      allowedFileTypes: ['image']
      allowedFileExtensions: ['jpg', 'jpeg', 'png']
      ajaxSettings:
        beforeSend: MainChannel.request 'main:app:authBeforeSend'
    fi.on 'fileunlock', =>
      response = @model.fetch()
      response.done =>
        @trigger 'photo:uploaded'
  onBeforeDestroy: ->
    @ui.fileinput.fileinput 'destroy'


class NameSelectView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div '.form-group', ->
      tc.label '.control-label', for:'select_name', 'Name'
    tc.select '.form-control', name:'select_name', ->
      for item in model.items
        item_atts =
          value: item.id
        if item.id is 'front'
          item_atts.selected = ''
        tc.option item_atts, item.id
  ui:
    nameSelect: 'select[name="select_name"]'
  triggers:
    'change @ui.nameSelect': 'name:changed'
    
    
class UploadMainView extends Marionette.View
  initialize: (options) ->
    ComicPhotoNames = AppChannel.request 'ComicPhotoNames'
    @nameCollection = new ComicPhotoNames
  templateContext: ->
    nameCollection: @nameCollection
  template: tc.renderable (model) ->
    names = model.nameCollection.toJSON()
    console.log "names", names
    tc.div '.listview-header', ->
      tc.text "Upload Photos for #{model.series} ##{model.issue}"
    tc.div '.row', ->
      tc.div '.col-sm-4', ->
        tc.div '.name-select'
        tc.div '.file-div'
      tc.div '.col-sm-8', ->
        tc.div '.photo-list'
  ui:
    fileinput: '.fileinput'
    photoList: '.photo-list'
    fileInputRegion: '.file-div'
    nameSelectRegion: '.name-select'
  regions:
    photoList: '@ui.photoList'
    fileInputRegion: '@ui.fileInputRegion'
    nameSelectRegion: '@ui.nameSelectRegion'
  childViewEvents:
    'photo:uploaded': 'photoUploaded'
    'name:changed': 'nameChanged'
    
    
  photoUploaded: ->
    @showPhotoList()
    @getRegion('fileInputRegion').empty()

  showPhotoList: ->
    view = new PhotosView
      model: @model
    @showChildView 'photoList', view
    
  nameChanged: ->
    nsview = @getChildView 'nameSelectRegion'
    name = nsview.ui.nameSelect.val()
    console.log "nameChanged", name
    comic = @model.toJSON()
    photos = makePhotosObject @model.toJSON()
    if name and name not in Object.keys photos
      view = new FileInputView
        model: @model
        photoName: name
      @showChildView 'fileInputRegion', view
    else
      @getRegion('fileInputRegion').empty()
      
  onRender: ->
    res = @nameCollection.fetch()
    res.done =>
      console.log "nameCollection", @nameCollection
      @showPhotoList()
      view = new NameSelectView
        collection: @nameCollection
      @showChildView 'nameSelectRegion', view
       
        

    
    

module.exports = UploadMainView
