$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ modal_close_button } = require 'tbirds/templates/buttons'

JsonView = require './comicjson'
HasImageModal = require './has-image-modal'
BaseComicEntryView = require './base-comic-entry'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

BaseModalView = MainChannel.request 'main:app:BaseModalView'

class IFrameModalView extends BaseModalView
  template: tc.renderable (model) ->
    main = model.mainsection
    tc.div '.modal-dialog.modal-lg', ->
      tc.div '.modal-content', ->
        tc.div '.modal-body', ->
          src = model.src.replace 'http://', '//'
          tc.iframe style:"width:97%;height:75vh;", src: src
        tc.div '.modal-footer', ->
          tc.ul '.list-inline', ->
            btnclass = 'btn.btn-default.btn-sm'
            tc.li "#close-modal", ->
              modal_close_button 'Close', 'check'
              

########################################
class ComicImageView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    img = AppChannel.request 'fix-image-url', model.image_src
    tc.img src:img
  ui:
    image: 'img'
  triggers:
    'click @ui.image': 'show:image:modal'
  behaviors: [HasImageModal]
  onDomRefresh: ->
    @trigger 'show:image'
    
class ComicEntryView extends BaseComicEntryView
  show_comic_json: (event) ->
    target = event.target
    if target.tagName is "A"
      return
    view = new JsonView
      model: @model
    MainChannel.request 'show-modal', view

  onDomRefresh: ->
    super
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
      @_show_comic_image model
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
          
  _add_comic_to_db: (url, content) =>
    #console.log "_add_comic_to_db", @model
    model = AppChannel.request 'db:clzpage:new'
    model.set 'url', url
    cdoc = $.parseHTML content
    links = []
    for e in cdoc
      if e.tagName == 'LINK' and e.rel == 'image_src'
        links.push e
    if links.length > 1
      MessageChannel.request 'warning', 'Too many links for this comic.'
    link = links[0]
    model.set 'image_src', link.href
    collection = AppChannel.request 'db:clzpage:collection'
    collection.add model
    response = model.save()
    response.done =>
      @_show_comic_image model
      
    
  _get_comic_from_db: ->
    links = @model.get 'links'
    url = links.link.url
    u = new URL url
    collection = AppChannel.request 'db:clzpage:collection'
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
        @_set_local_images_url clzpage
        @_show_comic_image clzpage

  _set_local_images_url: (clzpage) ->
    url = clzpage.get 'url'
    image_src = clzpage.get 'image_src'
    AppChannel.request 'add-comic-image-url', url, image_src
    
  show_comic: ->
    links = @model.get 'links'
    url = links.link.url
    collection = AppChannel.request 'db:clzpage:collection'
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


