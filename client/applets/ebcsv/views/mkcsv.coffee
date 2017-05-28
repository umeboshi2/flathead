Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ form_group_input_div } = require 'tbirds/templates/forms'

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
simple_comic_info = tc.renderable (model) ->
  main = model.mainsection
  tc.div '.listview-list-entry', ->
    tc.text "#{main.series.displayname} #{main.title}"

simple_comic_list = tc.renderable () ->
  tc.div ->
    tc.div '#comiclist-container.listview-list'


class ComicEntryView extends Backbone.Marionette.View
  template: simple_comic_info

class ComicListView extends Backbone.Marionette.CollectionView
  childView: ComicEntryView

class ComicsView extends Backbone.Marionette.View
  regions:
    list: '#comiclist-container'
  template: simple_comic_list
  onRender: ->
    view = new ComicListView
      collection: @collection
    @showChildView 'list', view
    
module.exports = ComicsView


