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

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

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
    tc.img '.thumb.media-object', src:img
  ui:
    image: 'img'
  triggers:
    'click @ui.image': 'show:image:modal'
  behaviors: [HasImageModal]
  onDomRefresh: ->
    @trigger 'show:image'

class BaseComicEntryView extends Marionette.View
  ui:
    info_btn: '.info-button'
    clz_link: '.clz-link'
    item: '.item'
    image: '.comic-image'
  regions:
    image: '@ui.image'
  events:
    'click @ui.info_btn': 'show_comic_json'
    'click @ui.clz_link': 'show_comic_page'
    'mouseenter @ui.item': 'mouse_enter_item'
    'mouseleave @ui.item': 'mouse_leave_item'
  # relay show:image event to parent
  childViewTriggers:
    'show:image': 'show:image'
  templateContext: ->
    context =
      entryClasses: ".item.listview-list-entry.thumbnail"
      columnClass: "col-sm-2"
      infoButtonClasses: ".fa.fa-info.fa-pull-left.btn.btn-default.btn-sm"
    # do something if necessary
    if @model.has 'inDatabase'
      inDatabase = @model.get 'inDatabase'
      if inDatabase
        console.log "MODEL IN DATABASE"
        context.entryClasses = '.item.alert.alert-success'
      else
        context.entryClasses = '.item.alert.alert-danger'

    atts = @model.toJSON()
    unless atts?.series
      context.series = atts.mainsection.series.displayname
    unless atts?.issue
      context.issue = atts.issue
    unless atts?.issueext
      if atts?.issueext
        context.issueext = atts.issueext
    unless atts?.url
      url = atts?.links?.link?.url
      if url
        context.url = url
      else
        context.url = 'UNAVAILABLE'
    return context
    
  mouse_enter_item: (event) ->
    @ui.info_btn.show()
  mouse_leave_item: (event) ->
    @ui.info_btn.hide()
  template: tc.renderable (model) ->
    issue = model.issue
    if model?.issueext
      issue = "#{model.issue}#{model.issueext}"
    tc.div "#{model.entryClasses}.#{model.columnClass}", ->
      tc.div ".comic-image", ->
        tc.i ".fa.fa-spinner.fa-spin"
        tc.text " loading..."
      tc.div ".caption", ->
        tc.span ->
          tc.i ".info-button#{model.infoButtonClasses}"
          tc.h5 style:"text-overflow: ellipsis;",
          "#{model.series} ##{issue}"
        if model.url isnt 'UNAVAILABLE'
          tc.a '.clz-link',
          href:"#{model.url}", target:'_blank', 'cloud link'
        else
          console.log "MODEL.URL", model.url
          tc.span ".alert.alert-danger", "URL UNAVAILABLE"
          
  onDomRefresh: ->
    @ui.info_btn.hide()
    
  show_comic_page: (event) ->
    event.preventDefault()
    target = event.target
    if target.tagName is "A"
      view = new IFrameModalView
        model: new Backbone.Model src:target.href
      MainChannel.request 'show-modal', view
      
  _show_comic_image: (clzpage) ->
    view = new ComicImageView
      model: clzpage
    @showChildView 'image', view
    
        
module.exports = BaseComicEntryView



