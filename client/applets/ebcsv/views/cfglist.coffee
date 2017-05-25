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

simple_config_info = tc.renderable (cfg) ->
  tc.div '.cfgitem.listview-list-entry', ->
    tc.a href:'#ebcsv/viewcfg/' + cfg.name, cfg.name
    tc.i ".delete-cfg-button.fa.fa-close.btn.btn-default.btn-xs",
    cfg:cfg.name

simple_cfg_list = tc.renderable () ->
  tc.div ->
    tc.a '.btn.btn-default', href:'#ebcsv/addcfg', "Add cfg"
    tc.div '#cfglist-container.listview-list'


class SimpleCfgInfoView extends Backbone.Marionette.View
  template: simple_config_info

class SimpleCfgListView extends Backbone.Marionette.CompositeView
  childView: SimpleCfgInfoView
  template: simple_cfg_list
  childViewContainer: '#cfglist-container'
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
    delete_buttons = $ '.delete-cfg-button'
    delete_buttons.hide()
    delete_buttons.on 'click', (event) =>
      console.log "destroy something!!!"
      target = $ event.currentTarget
      console.log "currentTarget", target
      cfg = target.attr 'cfg'
      console.log "target.attr cfg", cfg
      model = AppChannel.request 'get-ebcsv-config', cfg
      console.log "destroy model", model
      model.destroy()
      @masonry.reloadItems()
      @masonry.layout()
    @set_layout()
      
  set_layout: ->
    @masonry.reloadItems()
    @masonry.layout()
    cfg = $ '.cfgitem'
    handlerIn = (event) ->
      console.log "set_layout handlerIn", event
      window.enterevent = event
      button = $(event.target).find '.delete-cfg-button'
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
      button = $(event.target).find '.delete-cfg-button'
      button.hide()
    cfg.hover handlerIn, handlerOut
    
module.exports = SimpleCfgListView

