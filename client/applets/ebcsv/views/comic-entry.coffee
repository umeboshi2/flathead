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

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

show_modal = (view, backdrop=false) ->
  app = MainChannel.request 'main:app:object'
  modal_region = app.getView().getRegion 'modal'
  modal_region.backdrop = backdrop
  modal_region.show view

class ImageModalView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    main = model.mainsection
    tc.div '.modal-dialog', ->
      tc.div '.modal-content', ->
        tc.div '.modal-body', ->
          tc.img src: model.image_src
        tc.div '.modal-footer', ->
          tc.ul '.list-inline', ->
            btnclass = 'btn.btn-default.btn-sm'
            tc.li "#confirm-delete-button", ->
              modal_close_button 'Close', 'check'


class IFrameModalView extends Backbone.Marionette.View
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
            tc.li "#confirm-delete-button", ->
              modal_close_button 'Close', 'check'



########################################
class ComicImageView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    img = model.image_src.replace '/lg/', '/sm/'
    tc.img src:img
  onDomRefresh: ->
    AppChannel.request 'reload-layout'
  ui:
    image: 'img'
  events:
    'click @ui.image': 'show_large_image'
  show_large_image: ->
    view = new ImageModalView
      model: @model
    show_modal view
    

class ComicEntryView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    main = model.mainsection
    tc.div '.item.listview-list-entry.thumbnail.col-sm-2', ->
      tc.div '.comic-image', ->
        tc.i '.fa.fa-spinner.fa-spin'
        tc.text 'loading'
      tc.div '.caption', ->
        tc.span ->
          tc.i '.info-button.fa.fa-info.fa-pull-left.btn.btn-default.btn-sm'
          tc.h5 style:"text-overflow: ellipsis;",
          "#{main.series.displayname} ##{model.issue}"
        label = main?.title or model?.edition?.displayname
        label = label or tc.strong 'UNTITLED'
        tc.a '.clz-link',
        href:"#{model.links.link.url}", target:'_blank', label
  regions:
    info: '.comic-info'
    image: '.comic-image'
  ui:
    info_btn: '.info-button'
    item: '.item'
    clz_link: '.clz-link'
  events:
    'click @ui.info_btn': 'show_comic_json'
    'click @ui.clz_link': 'show_comic_page'
    'mouseenter @ui.item': 'mouse_enter_item'
    'mouseleave @ui.item': 'mouse_leave_item'
    
  mouse_enter_item: (event) ->
    #console.log "mouse_enter_item", event
    @ui.info_btn.show()
    
  mouse_leave_item: (event) ->
    #console.log "mouse_leave_item", event
    @ui.info_btn.hide()
    
  show_comic_json: (event) ->
    target = event.target
    if target.tagName is "A"
      return
    view = new JsonView
      model: @model
    show_modal view

  show_comic_page: (event) ->
    event.preventDefault()
    target = event.target
    if target.tagName is "A"
      view = new IFrameModalView
        model: new Backbone.Model src:target.href
      show_modal view
      
  onDomRefresh: ->
    @ui.info_btn.hide()
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
    cdoc = $.parseHTML content
    links = []
    for e in cdoc
      if e.tagName == 'LINK' and e.rel == 'image_src'
        links.push e
    if links.length > 1
      MessageChannel.request 'warning', 'Too many links for this comic.'
    link = links[0]
    model.set 'image_src', link.href
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


