$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'
require 'jquery-ui/ui/widgets/draggable'
require 'jquery-ui/ui/widgets/droppable'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ modal_close_button } = require 'tbirds/templates/buttons'

JsonView = require './comicjson'
HasImageModal = require './has-image-modal'
BaseComicEntryView = require './base-comic-entry'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

BaseModalView = MainChannel.request 'main:app:BaseModalView'

make_simple_dl = tc.renderable (dt, dd) ->
  tc.dl '.dl-horizontal', ->
    tc.dt dt
    tc.dd dd
    
make_entry_buttons = tc.renderable (model) ->
  btn_style = '.btn.btn-default'
  tc.span ".info-button#{btn_style}", ->
    tc.i '.fa.fa-info', 'Info'
    
dtFields = ['seriesgroup', 'series', 'issue', 'currentprice',
  'publisher', 'ReleaseDate', 'quantity']

bstableclasses = [
  'table'
  'table-striped'
  'table-bordered'
  'table-hover'
  #'table-condensed'
  ]
  
make_comics_row = tc.renderable (model) ->
  tc.div '.col-sm-8', ->
    tc.table ".#{bstableclasses.join('.')}", ->
      for field in dtFields
        tc.tr ->
          tc.td -> tc.strong field
          tc.td model[field]
      
########################################
class ComicEntryView extends BaseComicEntryView
  templateContext: ->
    context = super
    context.columnClass = 'col-sm-5'
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

  template: tc.renderable (model) ->
    issue = model.issue
    if model?.issueext
      issue = "#{model.issue}#{model.issueext}"
    # .panel.panel-info
    tc.div "#{model.entryClasses}.#{model.columnClass}", ->
      tc.p '.text-center', -> tc.strong "#{model.series} ##{issue}"
      tc.div '.row', ->
        tc.div '.col-sm-2', ->
          tc.div '.comic-image.thumb'
          make_entry_buttons model
        tc.div '.col-sm-3.col-sm-offset-1', ->
          make_comics_row model
      
  # don't hide info button
  mouse_leave_item: (event) ->
    @ui.info_btn.show()
          
  show_comic_json: (event) ->
    target = event.target
    if target.tagName is "A"
      return
    else
      Model = AppChannel.request "db:clzcomic:modelClass"
      response = @model.fetch()
      response.done =>
        view = new JsonView
          model: @model
        MainChannel.request 'show-modal', view

  onDomRefresh: ->
    @$el.draggable()
    @$el.droppable()
    url = @model.get 'url'
    if url isnt 'UNAVAILABLE'
      image_src = @model.get 'image_src'
      if image_src is 'UNSET' or image_src is undefined
        @_get_comic_data url, @_scrapeAndSetImageSrc
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
          
  _scrapeAndSetImageSrc: (url, content) =>
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
    
  _show_unavailable_image: ->
    view = new Marionette.View
      template: tc.renderable ->
        tc.i '.fa.fa-exclamation-triangle.fa-4x',
        style:"width:74px;height:115px;"
    @showChildView 'image', view
    
  show_comic: ->
    image_src = @model.get 'image_src'
    console.log "show_comic image_src", image_src

      

module.exports = ComicEntryView


