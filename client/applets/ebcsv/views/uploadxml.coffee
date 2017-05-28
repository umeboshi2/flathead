Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

########################################
dropzone_template = tc.renderable (model) ->
  tc.article '.document-view.content', ->
    tc.div '.body', ->
      tc.div '.panel.panel-default', ->
        tc.div '.panel-heading', 'Drop it'
        tc.div '.panel-body', ->
          tc.div '.mydropzone.pill.pill-default', type:'file', "Drop Something"
          tc.div '.parse-btn.btn.btn-default', style:'display:none', ->
            tc.text 'Parse File'
          
  
          
class DropZoneView extends Backbone.Marionette.View
  template: dropzone_template
  droppedFile: null
  ui:
    dropzone: '.mydropzone'
    parse_btn: '.parse-btn'
  events:
    'dragover @ui.dropzone': 'handle_dragOver'
    'dragenter @ui.dropzone': 'handle_dragEnter'
    'drop @ui.dropzone': 'handle_drop'
    'click @ui.parse_btn': 'parse_xml'
    
  handle_drop: (event) ->
    event.preventDefault()
    @ui.dropzone.css 'border', '0px'
    dt = event.originalEvent.dataTransfer
    file = dt.files[0]
    #fr = FileReader(file)
    console.log 'file is', file
    @ui.dropzone.text "File: #{file.name}"
    @droppedFile = file
    @ui.parse_btn.show()
    
  handle_dragOver: (event) ->
    event.preventDefault()
    event.stopPropagation()
    
  handle_dragEnter: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @ui.dropzone.css 'border', '2px dotted'

  successfulParse: =>
    @ui.dropzone.text "Parse Successful"
    if __DEV__
      window.comics = AppChannel.request 'get-comics'
    navigate_to_url "#ebcsv"
    
  parse_xml: ->
    @ui.dropzone.text "Reading xml file..."
    console.log "PARSE #{@droppedFile.name}"
    reader = new FileReader()
    reader.onload = (event) =>
      content = event.target.result
      @ui.dropzone.text 'Parsing xml.....'
      AppChannel.request 'parse-comics-xml', content, @successfulParse
    reader.readAsText(@droppedFile)
    @ui.parse_btn.hide()
    
module.exports = DropZoneView


