_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
JView = require 'json-view'
require 'json-view/devtools.css'
marked = require 'marked'

#navigate_to_url = require 'tbirds/util/navigate-to-url'
ConfirmDeleteModal = require 'tbirds/delete-named-model'

show_modal = (view, backdrop=false) ->
  app = MainChannel.request 'main:app:object'
  modal_region = app.getView().getRegion 'modal'
  modal_region.backdrop = backdrop
  modal_region.show view


MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'ebcsv'

class JsonView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    main = model.mainsection
    tc.div '.listview-header', ->
      tc.text "#{main.series.displayname} ##{main.issue}"
    tc.div '.expand-button.btn.btn-default', 'Expand'
    tc.div '.panel'
  ui:
    body: '.panel'
    expand_btn: '.expand-button'
  events:
    'click @ui.expand_btn': 'expand_view'

  expand_view: ->
    if @expanded_view
      @json_view.collapse true
      @expanded_view = false
      @ui.expand_btn.text 'Expand'
    else
      @json_view.expand true
      @expanded_view = true
      @ui.expand_btn.text 'Collapse'
    
  onDomRefresh: ->
    @expanded_view = false
    #view = new JView @model.get 'content'
    @json_view = new JView @model.toJSON()
    @ui.body.prepend @json_view.dom
  
module.exports = JsonView
