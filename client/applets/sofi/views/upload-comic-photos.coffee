Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

fileinput = require 'bootstrap-fileinput'
require 'bootstrap-fileinput/css/fileinput.css'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'
  
apiroot = '/api/dev/misc'




class UploadMainView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "Upload Photos for #{model.series} ##{model.issue}"
    if model.photos.length
      tc.div ->
        for p in model.photos
          tc.div 'listview-list-entry', ->
            tc.img src:"/photos/#{p.filename}", style:'height:100px'
    tc.article '.document-view.content', ->
      tc.div '.body', ->
        "Hello there"
    tc.div '.file-div', ->
      tc.input '.fileinput', name:'comicphoto', type:'file'

  ui:
    fileinput: '.fileinput'
    
  onDomRefresh: () ->
    comic_id = @model.get 'comic_id'
    fi = @ui.fileinput.fileinput
      uploadUrl: "#{apiroot}/upload-photo"
      uploadExtraData:
        comic_id: comic_id
      ajaxSettings:
        beforeSend: MainChannel.request 'main:app:authBeforeSend'
    window.fi = fi
        

    
    

module.exports = UploadMainView
