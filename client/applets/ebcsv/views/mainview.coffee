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
delbtn_cls = '.delete-cfg-button'
dialog_view = tc.renderable (blog) ->
  tc.div '.modal-header', ->
    tc.h2 'This is a modal!'
  tc.div '.modal-body', ->
    tc.p 'here is some content'
  tc.div '.modal-footer', ->
    tc.button '#modal-cancel-button.btn', 'cancel'
    tc.button '#modal-ok-button.btn.btn-default', 'Ok'

simple_config_info = tc.renderable (cfg) ->
  tc.div '.cfgitem.listview-list-entry', ->
    tc.a href:"#ebcsv/cfg/view/#{cfg.id}", cfg.name
    tc.i "#{delbtn_cls}.fa.fa-close.btn.btn-default.btn-xs",
    cfg:cfg.name

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


