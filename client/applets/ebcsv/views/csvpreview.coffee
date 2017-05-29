$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'
#require('editable-table/mindmup-editabletable')

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ form_group_input_div } = require 'tbirds/templates/forms'

ComicEntryView = require './comic-entry'
ComicListView = require './comic-list'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

require('editable-table')($)
# we need to use the css to hide the inputs in
# table template
require 'editable-table/editable-table.css'
table_template = tc.renderable ->
  tc.table '.table', 'data-editable':'', 'data-editable-spy':'', ->
    tc.thead ->
      tc.tr ->
        tc.th 'ID'
        tc.th 'Name'
    tc.tbody ->
      tc.tr ->
        tc.td ->
          tc.input name:'id', placeholder:''
        tc.td ->
          tc.input name:'name', placeholder:''
  

########################################
class ComicsView extends Backbone.Marionette.View
  templateContext: ->
    options = @options
    options.ebcfg_collection = AppChannel.request 'ebcfg-collection'
    options.ebdsc_collection = AppChannel.request 'ebdsc-collection'
    options
  regions:
    body: '.body'
  template: tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text "Preview CSV"
    #tc.div '.mkcsv-button.btn.btn-default', "Make CSV"
    #tc.div '.show-comics-button.btn.btn-default', "Show Comics"
    table_template()
    tc.div '.csvtable'
    tc.div '.body'
    tc.div '#cgrid'
            
        
      
  ui:
    cgrid: '#cgrid'
    mkcsv_btn: '.mkcsv-button'
    table: '.table'
    csvtable: '.csvtable'
    
  events:
    'click @ui.mkcsv_btn': 'make_csv'
    'click @ui.show_btn': 'show_comics'

  make_csv: ->
    cfg = AppChannel.request 'get-ebcfg', @ui.cfg_sel.val()
    dsc = AppChannel.request 'get-ebdsc', @ui.dsc_sel.val()
    AppChannel.request 'set-current-csv-cfg', cfg
    AppChannel.request 'set-current-csv-dsc', dsc

  onDomRefresh: ->
    #@ui.csvtable.editableTableWidget()
    
    #data = @collection.toJSON()
    for comic in @collection.toJSON()
      cdata = id:comic.id, name:comic.fulltitle
      @ui.table.editableTable 'add', cdata
    
  show_comics: ->
    view = new ComicListView
      collection: @collection
    @showChildView 'body', view
    
module.exports = ComicsView


