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
class ComicImageView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    img = model.image_src.replace '/lg/', '/sm/'
    tc.img src:img
  onDomRefresh: ->
    AppChannel.request 'reload-layout'
    

class ComicEntryView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    main = model.mainsection
    tc.div '.item.listview-list-entry.thumbnail.col-sm-2', ->
      tc.div '.comic-image', ->
        tc.i '.fa.fa-spinner.fa-spin'
        tc.text 'loading'
      tc.div '.caption', ->
        tc.h5 style:"text-overflow: ellipsis;",
        "#{main.series.displayname} ##{main.issue}"
        label = main?.title or model?.edition?.displayname
        label = label or tc.strong 'UNTITLED'
        tc.a href:"#{model.links.link.url}", label
  regions:
    info: '.comic-info'
    image: '.comic-image'
  ui:
    show_btn: '.show-comic'
    item: '.item'
  events:
    'click @ui.show_btn': 'show_comic'
    'click @ui.item': 'show_comic_json'

  show_comic_json: ->
    url = "#ebcsv/comic/view/#{@model.id}"
    navigate_to_url url
    
  onDomRefresh: ->
    @_get_comic_from_db()
    
  _get_comic_data: (url, cb) ->
    u = new URL url
    xhr = Backbone.ajax
      type: 'GET'
      dataType: 'html'
      url: "/clzcore#{u.pathname}"
    xhr.done ->
      cb url, xhr.responseText
    xhr.fail ->
      MessageChannel.request 'warning', "Couldn't get the info"
          
  _add_comic_to_db: (url, content) =>
    #console.log "_add_comic_to_db", @model
    model = AppChannel.request 'new-clzpage'
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
    model.set 'image_src', link.href
    model.set 'clzdata', @model.toJSON()
    collection = AppChannel.request 'clzpage-collection'
    collection.add model
    response = model.save()
    response.done =>
      @_show_comic_image model
      
    
  _get_comic_from_db: ->
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
        clzpage = collection.models[0]
        #console.log "we should have a model in the collection"
        @_show_comic_image clzpage
        
  _show_comic_image: (clzpage) ->
    urls = AppChannel.request 'get-comic-image-urls'
    url = clzpage.get 'url'
    image_src = clzpage.get 'image_src'
    urls[url] = image_src
    @ui.show_btn.hide()
    view = new ComicImageView
      model: clzpage
    #console.log "show image"
    @showChildView 'image', view
    
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
      #else
      #  console.log "we should have a model in the collection"
      

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
  
module.exports = ComicEntryView


