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
{ modal_close_button } = require 'tbirds/templates/buttons'

ComicEntryView = require './comic-entry'
ComicListView = require './comic-list'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

csvRowCollection = new Backbone.Collection
AppChannel.reply 'get-csvrow-collection', ->
  csvRowCollection

show_modal = (view, backdrop=false) ->
  app = MainChannel.request 'main:app:object'
  modal_region = app.getView().getRegion 'modal'
  modal_region.backdrop = backdrop
  modal_region.show view

############################################
# csv info preview dialogs
############################################
  
class ModalDescView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    main = model.mainsection
    tc.div '.modal-dialog', ->
      tc.div '.modal-content', ->
        tc.h4 "Title: #{model.Title}"
        tc.div '.modal-body', ->
          tc.h4 "Description:"
          tc.hr()
          tc.div '.panel', ->
            tc.raw model.Description
        tc.div '.modal-footer', ->
          tc.ul '.list-inline', ->
            btnclass = 'btn.btn-default.btn-sm'
            tc.li "#modal-close-button", ->
              modal_close_button 'Close', 'check'

class ModalRowView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.div '.modal-dialog', ->
      tc.div '.modal-content', ->
        tc.h3 "Title: #{model.Title}"
        tc.div '.modal-body', ->
          tc.h4 "CSV Row:"
          tc.hr()
          tc.div '.panel', ->
            tc.dl '.dl-horizontal', ->
              Object.keys(model).forEach (field) ->
                tc.dt field
                tc.dd model[field]
        tc.div '.modal-footer', ->
          tc.ul '.list-inline', ->
            tc.li "#modal-close-button", ->
              modal_close_button 'Close', 'check'

############################################
# csv table views
############################################
              
# text overflow for table cells
# https://stackoverflow.com/a/11877033
cell_styles = [
  'max-width:0'
  'overflow:hidden'
  'text-overflow:ellipsis'
  'white-space:nowrap'
  ]
cell_style = "#{cell_styles.join(';')};"

class CsvTableRow extends Backbone.Marionette.View
  tagName: 'tr'
  templateContext: ->
    options = @options
    options.csvheader = AppChannel.request 'get-csv-header'
    options
    
  template: tc.renderable (model) ->
    tc.td ->
      tc.div '.btn-group.btn-group-justified', ->
        tc.div '.show-desc-button.btn.btn-default.btn-xs', ->
          tc.i '.fa.fa-eye'
        tc.div '.show-row-button.btn.btn-default.btn-xs', ->
          tc.i '.fa.fa-list'
    Object.keys(model.csvheader).forEach (field) ->
      tc.td style:cell_style, model[field]
  ui:
    desc_btn: '.show-desc-button'
    row_btn: '.show-row-button'
  events:
    'click @ui.desc_btn': 'show_description'
    'click @ui.row_btn': 'show_row'

  show_row: ->
    console.log 'show_row'
    view = new ModalRowView
      model: @model
    show_modal view
    
  show_description: ->
    console.log 'show_description'
    view = new ModalDescView
      model: @model
    show_modal view
    
  
class CsvTableBody extends Backbone.Marionette.CollectionView
  tagName: 'tbody'
  childView: CsvTableRow

bstableclasses = [
  'table'
  'table-striped'
  'table-bordered'
  'table-hover'
  'table-condensed'
  ]
  
class CsvMainView extends Backbone.Marionette.View
  tagName: 'table'
  className: bstableclasses.join ' '
  templateContext: ->
    options = @options
    options.ebcfg_collection = AppChannel.request 'ebcfg-collection'
    options.ebdsc_collection = AppChannel.request 'ebdsc-collection'
    options.csvheader = AppChannel.request 'get-csv-header'
    options
    
  template: tc.renderable (model) ->
    tc.div '.table-responsive', ->
      tc.table ".#{bstableclasses.join '.'}", ->
        tc.thead ->
          tc.tr '.info', ->
            tc.td ->
              # FIXME the big eye is to get the
              # two view buttons to sit side by side.
              tc.i '.fa.fa-eye.fa-3x'
            Object.keys(model.csvheader).forEach (field) ->
              tc.th model.csvheader[field]
        tc.tbody()
      
  regions:
    body:
      el: 'tbody'
      replaceElement: true

  onRender: ->
    console.log "CsvMainView onRender"
    collection = AppChannel.request 'get-csvrow-collection'
    view = new CsvTableBody
      collection: collection
    @showChildView 'body', view
    
############################################
# Main view
############################################
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
    tc.div '.mkcsv-button.btn.btn-default', "Make CSV"
    tc.div '.body'
  ui:
    mkcsv_btn: '.mkcsv-button'
    
  events:
    'click @ui.mkcsv_btn': 'show_comics'
    
  show_comics: ->
    window.csvrows = @csvRowCollection
    MessageChannel.request 'info', 'coming soon yada, yada'
    
  createCsvRows: ->
    cfg = AppChannel.request 'get-current-csv-cfg'
    dsc = AppChannel.request 'get-current-csv-dsc'
    # FIXME set action in a form or button
    action = 'VerifyAdd'
    rows = []
    for comic in @collection.toJSON()
      options =
        action: action
        comic: comic
        cfg: cfg
        desc: dsc
      cdata = AppChannel.request 'create-csv-row-object', options
      rows.push cdata
    csvrows = AppChannel.request 'get-csvrow-collection'
    csvrows.set rows

  onRender: ->
    urls = AppChannel.request 'get-comic-image-urls'
    if not Object.keys(urls).length
      msg = "No pictures attached, please view comics, then create csv"
      MessageChannel.request 'warning', msg
    @createCsvRows()
    csvrows = AppChannel.request 'get-csvrow-collection'
    view = new CsvMainView
      collection: csvrows
    @showChildView 'body', view
    
      
    
module.exports = ComicsView


