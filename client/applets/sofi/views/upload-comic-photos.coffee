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

mkInputData = (field, label, placeholder) ->
  input_id: "input_#{field}"
  label: label
  input_attributes:
    name: field
    placeholder: placeholder

class PhotosView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div '.row', ->
      for p in model.photos
        tc.div '.listview-list-entry.col-sm-2', ->
          tc.div '.listview-header', p.name
          tc.img '.thumb', src:"/photos/#{p.filename}", style:"height:100px"

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
      ajaxSettings:
        beforeSend: MainChannel.request 'main:app:authBeforeSend'
    fi.on 'fileunlock', =>
      response = @model.fetch()
      response.done =>
        #@render()
        @trigger 'photo:uploaded'
    window.fi = fi
  onBeforeDestroy: ->
    @ui.fileinput.fileinput 'destroy'
  
class UploadMainView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "Upload Photos for #{model.series} ##{model.issue}"
    tc.div '.row', ->
      tc.div '.col-sm-4', ->
        make_field_input('name')(model)
        tc.div '.file-div'
      tc.div '.col-sm-8', ->
        tc.div '.photo-list'
  ui:
    fileinput: '.fileinput'
    photoList: '.photo-list'
    fileInputRegion: '.file-div'
    nameInput: '[name="name"]'
  regions:
    photoList: '@ui.photoList'
    fileInputRegion: '@ui.fileInputRegion'
  events:
    'change @ui.nameInput': 'onNameChange'
  childViewEvents:
    'photo:uploaded': 'photoUploaded'
  photoUploaded: ->
    @showPhotoList()
    @ui.nameInput.val ''
    @getRegion('fileInputRegion').empty()

  showPhotoList: ->
    view = new PhotosView
      model: @model
    @showChildView 'photoList', view
    
  onNameChange: ->
    name = @ui.nameInput.val()
    if name
      view = new FileInputView
        model: @model
        photoName: name
      @showChildView 'fileInputRegion', view
    else
      @getRegion('fileInputRegion').empty()
  onRender: ->
    @showPhotoList()
    
        

    
    

module.exports = UploadMainView
