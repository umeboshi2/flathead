Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

fileinput = require 'bootstrap-fileinput'
require 'bootstrap-fileinput/css/fileinput.css'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'
  
apiroot = '/api/dev/misc'


class PhotosView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.div '.row', ->
      for p in model.photos
        tc.div '.listview-list-entry.col-sm-2', ->
          tc.img '.thumb', src:"/photos/#{p.filename}", style:"height:100px"
  
class UploadMainView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "Upload Photos for #{model.series} ##{model.issue}"
    tc.div '.row', ->
      tc.div '.col-sm-4', ->
        tc.div '.file-div', ->
          tc.input '.fileinput', name:'comicphoto', type:'file'
      tc.div '.col-sm-8', ->
        tc.div '.photo-list'

  ui:
    fileinput: '.fileinput'
    photoList: '.photo-list'
  regions:
    photoList: '@ui.photoList'
  onRender: ->
    view = new PhotosView
      model: @model
    @showChildView 'photoList', view
  onDomRefresh: ->
    comic_id = @model.get 'comic_id'
    fi = @ui.fileinput.fileinput
      uploadUrl: "#{apiroot}/upload-photo"
      uploadExtraData:
        comic_id: comic_id
      ajaxSettings:
        beforeSend: MainChannel.request 'main:app:authBeforeSend'
    fi.on 'fileunlock', =>
      response = @model.fetch()
      response.done =>
        @render()
    window.fi = fi
        

    
    

module.exports = UploadMainView
