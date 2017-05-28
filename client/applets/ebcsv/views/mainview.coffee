$ = require 'jquery'
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
simple_comic_info = tc.renderable (model) ->
  main = model.mainsection
  tc.div '.listview-list-entry', ->
    #tc.div "#{main.series.displayname} #{main.title}"
    tc.a href:"#{model.links.link.url}",
    "#{main.series.displayname} #{main.title}"
    tc.div '.comic-info', "#{model.links.link.url}"
    tc.div '.show-comic.btn.btn-default', 'show'
    
simple_comic_list = tc.renderable () ->
  tc.div ->
    tc.div '#comiclist-container.listview-list'


class ComicEntryView extends Backbone.Marionette.View
  template: simple_comic_info
  regions:
    info: '.comic-info'
  ui:
    show_btn: '.show-comic'
  events:
    'click @ui.show_btn': 'show_comic'

  _get_comic_data: (url, cb) ->
    u = new URL url
    xhr = Backbone.ajax
      type: 'GET'
      dataType: 'html'
      url: "/clzcore#{u.pathname}"
    xhr.done =>
      cb url, xhr.responseText
    xhr.fail ->
      MessageChannel.request 'warning', "Couldn't get the info"
          
  _add_comic_to_db: (url, content) =>
    #console.log "_add_comic_to_db", @model
    model = AppChannel.request 'new-clzpage'
    #console.log "url is", url
    #console.log "content is", content
    model.set 'url', url
    model.set 'content', content
    cdoc = $.parseHTML content
    links = []
    for e in cdoc
      if e.tagName == 'LINK' and e.rel == 'image_src'
        links.push e
    if links.length > 1
      MessageChannel.request 'warning', 'Too many links for this comic.'
    link = links[0]
    model.set 'img_src', link.href
    model.set 'clzdata', @model.toJSON()
    collection = AppChannel.request 'clzpage-collection'
    collection.add model
    response = model.save()
    response.done ->
      navigate_to_url '#ebcsv'
    
    
  show_comic: ->
    links = @model.get 'links'
    url = links.link.url
    u = new URL url
    collection = AppChannel.request 'clzpage-collection'
    response = collection.fetch
      data:
        where:
          url: url
    response.fail ->
      msg = "There was a problem talking to the server"
      MessageChannel.request 'warning', msg
    response.done =>
      if collection.length > 1
        MessageChannel.request 'warning', "#{url} is not unique!"
      if not collection.length
        @_get_comic_data url, @_add_comic_to_db
      else
        console.log "we should have a model in the collection"
      

  get_comic_data: (url) ->
    u = new URL url
    xhr = Backbone.ajax
      type: 'GET'
      dataType: 'html'
      url: "/clzcore#{u.pathname}"
    xhr.done =>
      view = new Backbone.Marionette.View
        template: xhr.responseText
      @showChildView 'info', view
    xhr.fail ->
      MessageChannel.request 'warning', "Couldn't get the info"
  
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


