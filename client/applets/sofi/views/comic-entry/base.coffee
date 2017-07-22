$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
{ make_field_input
  make_field_select } = require 'tbirds/templates/forms'
{ modal_close_button } = require 'tbirds/templates/buttons'

IFrameModalView = require './iframe-modal'
ComicImageView = require './comic-image'
JsonView = require './json-modal'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

              
class BaseEntryView extends Marionette.View
  ui: ->
    info_btn: '.info-button'
    clz_link: '.clz-link'
    item: '.item'
    image: '.comic-image'
  regions: ->
    image: '@ui.image'
  events: ->
    'click @ui.info_btn': 'showJsonView'
    'click @ui.clz_link': 'showIframeView'
    
  showIframeView: (event) ->
    event.preventDefault()
    target = event.target
    if target.tagName is "A"
      view = new IFrameModalView
        model: new Backbone.Model src:target.href
      MainChannel.request 'show-modal', view
      
  showJsonView: (event) ->
    view = new JsonView
      model: @model
    MainChannel.request 'show-modal', view



class BaseComicEntryView extends Marionette.View
  ui: ->
    info_btn: '.info-button'
    clz_link: '.clz-link'
    item: '.item'
    image: '.comic-image'
  regions: ->
    image: '@ui.image'
    'mouseenter @ui.item': 'mouse_enter_item'
    'mouseleave @ui.item': 'mouse_leave_item'
  # relay show:image event to parent
  childViewTriggers: ->
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
          
      
  _show_comic_image: (clzpage) ->
    view = new ComicImageView
      model: clzpage
    @showChildView 'image', view
    
        
module.exports = BaseEntryView



