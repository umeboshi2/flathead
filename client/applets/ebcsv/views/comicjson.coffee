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
    tc.div '.panel'
  ui:
    body: '.panel'
    
  onDomRefresh: ->
    #view = new JView @model.get 'content'
    view = new JView @model.toJSON()
    @ui.body.prepend view.dom

  
module.exports = JsonView
