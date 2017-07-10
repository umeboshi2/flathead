$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

class IsEscapeModal extends Marionette.Behavior
  events:
    'click @ui.close_btn': 'onBeforeDestroy'
  keydownHandler: (event_object) =>
    keyCode = event_object.keyCode
    #console.log "keyCode", keyCode
    # handle escape('esc') key
    if keyCode == 27
      console.log "escape pressed", @ui.close_btn
      @ui.close_btn.children().click()
      console.log 'keydownHandler unbinding keydownHandler'
      $('html').unbind 'keydown', @keydownHandler
      #@ui.close_btn.click()
  onDomRefresh: ->
    console.log 'onDomRefresh setting keydownHandler'
    $('html').keydown @keydownHandler
  onBeforeDestroy: ->
    console.log 'onBeforeDestroy unbinding keydownHandler'
    $('html').unbind 'keydown', @keydownHandler
  
    
module.exports = IsEscapeModal
