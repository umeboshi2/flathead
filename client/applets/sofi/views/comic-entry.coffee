$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ modal_close_button } = require 'tbirds/templates/buttons'

BaseComicEntryView = require './base-comic-entry'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

class ComicEntryView extends BaseComicEntryView
  onDomRefresh: ->
    links = @model.get 'links'
    url = links?.link?.url
    if url
      @_prepare_show_comic_image url

  _prepare_show_comic_image: (url) ->
    urls = AppChannel.request 'get-comic-image-urls'
    if urls[url]
      model = new Backbone.Model
        image_src: urls[url]
        url: url
      @showComicImage model
    else
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
          
  parseContentShowImage: (url, content) =>
    cdoc = $.parseHTML content
    links = []
    for e in cdoc
      if e.tagName == 'LINK' and e.rel == 'image_src'
        links.push e
    if links.length > 1
      MessageChannel.request 'warning', 'Too many links for this comic.'
    link = links[0]
    image_src = link.href
    AppChannel.request 'add-comic-image-url', url, image_src
    model = new Backbone.Model
      url: url
      image_src: image_src
    @showComicImage model
      
    
  _get_comic_from_db: ->
    links = @model.get 'links'
    url = links.link.url
    u = new URL url
    collection = AppChannel.request 'db:clzcomic:collection'
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
        @_get_comic_data url, @parseContentShowImage
      else
        model = collection.models[0]
        @showComicImage model



  _set_local_images_url: (clzpage) ->
    url = clzpage.get 'url'
    image_src = clzpage.get 'image_src'
    AppChannel.request 'add-comic-image-url', url, image_src
    
  show_comic: ->
    links = @model.get 'links'
    url = links.link.url
    collection = AppChannel.request 'db:clzcomic:collection'
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
        @_get_comic_data url, @parseContentShowImage
      

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


