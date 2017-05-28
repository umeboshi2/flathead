Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

########################################
delbtn_cls = '.delete-cfg-button'
dialog_view = tc.renderable (blog) ->
  tc.div '.modal-header', ->
    tc.h2 'This is a modal!'
  tc.div '.modal-body', ->
    tc.p 'here is some content'
  tc.div '.modal-footer', ->
    tc.button '#modal-cancel-button.btn', 'cancel'
    tc.button '#modal-ok-button.btn.btn-default', 'Ok'

simple_config_info = tc.renderable (cfg) ->
  tc.div '.cfgitem.listview-list-entry', ->
    tc.a href:"#ebcsv/cfg/view/#{cfg.id}", cfg.name
    tc.i "#{delbtn_cls}.fa.fa-close.btn.btn-default.btn-xs",
    cfg:cfg.name

simple_cfg_list = tc.renderable () ->
  tc.div ->
    tc.a '.btn.btn-default', href:'#ebcsv/cfg/add', "Add cfg"
    tc.div '#cfglist-container.listview-list'


class SimpleCfgInfoView extends Backbone.Marionette.View
  template: simple_config_info

class SimpleCfgListView extends Backbone.Marionette.CompositeView
  childView: SimpleCfgInfoView
  template: simple_cfg_list
  childViewContainer: '#cfglist-container'
  msnry_iclass: '.cfgitem'
  ui:
    cfglist: '#cfglist-container'
  onBeforeDestroy: ->
    @masonry.destroy()

  onDomRefresh: ->
    @masonry = new Masonry '#cfglist-container',
      gutter: 2
      isInitLayout: false
      itemSelector: '.cfgitem'
      columnWidth: 100
    delete_buttons = $ delbtn_cls
    delete_buttons.hide()
    delete_buttons.on 'click', (event) =>
      target = $ event.currentTarget
      cfg = target.attr 'cfg'
      model = AppChannel.request 'get-ebcsv-config', cfg
      model.destroy()
      console.warn "remove from collection!!!"
      @masonry.reloadItems()
      @masonry.layout()
    @set_layout()
      
  set_layout: ->
    @masonry.reloadItems()
    @masonry.layout()
    cfg = $ '.cfgitem'
    handlerIn = (event) ->
      window.enterevent = event
      button = $(event.target).find delbtn_cls
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
      button = $(event.target).find delbtn_cls
      button.hide()
    cfg.hover handlerIn, handlerOut


Templates = require 'tbirds/templates/basecrud'

Views = require './basecrudviews'

ItemTemplate = Templates.base_item_template 'ebcfg', 'ebcsv'
        
ListTemplate = Templates.base_list_template 'ebcfg'

class ItemView extends Views.BaseItemView
  route_name: 'ebcsv'
  template: ItemTemplate
  item_type: 'ebcfg'
  

  
class ListView extends Views.BaseListView
  route_name: 'ebcsv'
  childView: ItemView
  template: ListTemplate
  childViewContainer: '#ebcfg-container'
  item_type: 'ebcfg'
    
    
module.exports = ListView

