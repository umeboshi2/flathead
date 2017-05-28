Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

########################################
dialog_view = tc.renderable (blog) ->
  tc.div '.modal-header', ->
    tc.h2 'This is a modal!'
  tc.div '.modal-body', ->
    tc.p 'here is some content'
  tc.div '.modal-footer', ->
    tc.button '#modal-cancel-button.btn', 'cancel'
    tc.button '#modal-ok-button.btn.btn-default', 'Ok'

simple_config_info = tc.renderable (dsc) ->
  tc.div '.dscitem.listview-list-entry', ->
    tc.a href:"#ebcsv/dsc/view/#{dsc.id}", dsc.name
    tc.i ".delete-dsc-button.fa.fa-close.btn.btn-default.btn-xs",
    dsc:dsc.name

simple_dsc_list = tc.renderable () ->
  tc.div ->
    tc.a '.btn.btn-default', href:'#ebcsv/dsc/add', "Add dsc"
    tc.div '#dsclist-container.listview-list'


class SimpleDscInfoView extends Backbone.Marionette.View
  template: simple_config_info

class SimpleDscListView extends Backbone.Marionette.CompositeView
  childView: SimpleDscInfoView
  template: simple_dsc_list
  childViewContainer: '#dsclist-container'
  ui:
    dsclist: '#dsclist-container'
  onBeforeDestroy: ->
    @masonry.destroy()

  onDomRefresh: ->
    @masonry = new Masonry '#dsclist-container',
      gutter: 2
      isInitLayout: false
      itemSelector: '.dscitem'
      columnWidth: 100
    delete_buttons = $ '.delete-dsc-button'
    delete_buttons.hide()
    delete_buttons.on 'click', (event) =>
      console.log "destroy something!!!"
      target = $ event.currentTarget
      console.log "currentTarget", target
      dsc = target.attr 'dsc'
      console.log "target.attr dsc", dsc
      model = AppChannel.request 'get-ebcsv-config', dsc
      console.log "destroy model", model
      model.destroy()
      @masonry.reloadItems()
      @masonry.layout()
    @set_layout()
      
  set_layout: ->
    @masonry.reloadItems()
    @masonry.layout()
    dsc = $ '.dscitem'
    handlerIn = (event) ->
      console.log "set_layout handlerIn", event
      window.enterevent = event
      button = $(event.target).find '.delete-dsc-button'
      button.show()
      # set button to disappear after two seconds
      # without this, some buttons appear to stick
      # and stay when the mouse jumps between entries
      # too quickly.
      # FIXME configure time elsewhere?
      setTimeout () ->
        button.hide()
      , 2000
    handlerOut = (event) ->
      window.leaveevent = event
      button = $(event.target).find '.delete-dsc-button'
      button.hide()
    dsc.hover handlerIn, handlerOut
    
Templates = require 'tbirds/templates/basecrud'

Views = require './basecrudviews'

ItemTemplate = Templates.base_item_template 'ebdsc', 'ebcsv'
        
ListTemplate = Templates.base_list_template 'ebdsc'

class ItemView extends Views.BaseItemView
  route_name: 'ebcsv'
  template: ItemTemplate
  item_type: 'ebdsc'
  

  
class ListView extends Views.BaseListView
  route_name: 'ebcsv'
  childView: ItemView
  template: ListTemplate
  childViewContainer: '#ebdsc-container'
  item_type: 'ebdsc'
    
    
module.exports = ListView


