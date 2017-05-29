Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ form_group_input_div } = require 'tbirds/templates/forms'

ComicEntryView = require './comic-entry'
ComicListView = require './comic-list'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'


mkInputData = (field, label, placeholder) ->
  input_id: "input_#{field}"
  label: label
  input_attributes:
    name: field
    placeholder: placeholder

csv_cfg_select = tc.renderable (collection) ->
  tc.div '.form-group', ->
    tc.label '.control-label', for:'select_cfg', 'Config'
  tc.select '.form-control', name:'select_cfg', ->
    for m in collection.models
      name = m.get 'name'
      tc.option selected:null, value:m.id, name
    
csv_dsc_select = tc.renderable (collection) ->
  tc.div '.form-group', ->
    tc.label '.control-label', for:'select_dsc', 'Description'
  tc.select '.form-control', name:'select_dsc', ->
    for m in collection.models
      name = m.get 'name'
      tc.option selected:null, value:m.id, name



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
    tc.div '.mkcsv-form', ->
      csv_cfg_select model.ebcfg_collection
      csv_dsc_select model.ebdsc_collection
    tc.div '.mkcsv-button.btn.btn-default', "Make CSV"
    tc.div '.show-comics-button.btn.btn-default', "Show Comics"
    tc.div '.body'
  ui:
    mkcsv_btn: '.mkcsv-button'
  events:
    'click @ui.mkcsv_btn': 'make_csv'
    'click @ui.show_btn': 'show_comics'

  make_csv: ->
    cfg = AppChannel.request 'get-ebcfg', @ui.cfg_sel.val()
    dsc = AppChannel.request 'get-ebdsc', @ui.dsc_sel.val()
    AppChannel.request 'set-current-csv-cfg', cfg
    AppChannel.request 'set-current-csv-dsc', dsc
    
  show_comics: ->
    view = new ComicListView
      collection: @collection
    @showChildView 'body', view
    
module.exports = ComicsView


