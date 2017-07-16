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


########################################
class ComicEntryView extends BaseComicEntryView
  templateContext: ->
    context = super
    context.columnClass = 'col-sm-2'
    # do something if necessary
    atts = @model.toJSON()
    unless atts?.series
      context.series = atts.mainsection.series.displayname
    unless atts?.issue
      context.issue = atts.issue
    unless atts?.url
      url = atts?.links?.link?.url
      if url
        context.url = url
      else
        context.url = 'UNAVAILABLE'
    return context
    
  show_comic_json: (event) ->
    target = event.target
    if target.tagName is "A"
      return
    else
      Model = AppChannel.request "db:clzcomic:modelClass"
      response = @model.fetch()
      response.done =>
        console.log "FETCHED COMIC", @model
        #view = new JsonView
        #  model: new Model @model.get('content')
        view = new JsonView
          model: @model
        MainChannel.request 'show-modal', view

  show_comic_page: (event) ->
    event.preventDefault()
    target = event.target
    if target.tagName is "A"
      view = new IFrameModalView
        model: new Backbone.Model src:target.href
      MainChannel.request 'show-modal', view
      
  onDomRefresh: ->
    @ui.info_btn.hide()
    url = @model.get 'url'
    if url isnt 'UNAVAILABLE'
      image_src = @model.get 'image_src'
      if image_src is 'UNSET' or image_src is undefined
        console.log "_get_image_src"
        @_get_comic_from_db()
      else
        model = new Backbone.Model
          image_src: image_src
          url: url
        # FIXME
        # we don't need the "false" when we get the
        # comics from the db
        @_show_comic_image model, false
    else
      # FIXME use replacement "missing image"
      console.warn "NO IMAGE"
      @_show_unavailable_image()
      
    
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
    #model = AppChannel.request 'db:clzpage:new'
    #model.set 'url', url
    cdoc = $.parseHTML content
    links = []
    for e in cdoc
      if e.tagName == 'LINK' and e.rel == 'image_src'
        links.push e
    if links.length > 1
      MessageChannel.request 'warning', 'Too many links for this comic.'
    link = links[0]
    @model.set 'image_src', link.href
    response = @model.save()
    response.done =>
      @_show_comic_image @model
      
    
  _get_comic_from_db: ->
    console.log "_get_comic_from_db:MODEL", @model
    url = @model.get 'url'
    @_get_comic_data url, @_add_comic_to_db


  _show_unavailable_image: ->
    view = new Marionette.View
      template: tc.renderable ->
        tc.i '.fa.fa-exclamation-triangle'
    @showChildView 'image', view
    
  show_comic: ->
    image_src = @model.get 'image_src'
    console.log "show_comic image_src", image_src

    #if not collection.length
    #  @_get_comic_data url, @_add_comic_to_db
      

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


