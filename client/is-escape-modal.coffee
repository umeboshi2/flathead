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
      @ui.close_btn.children().click()
      $('html').unbind 'keydown', @keydownHandler
  onDomRefresh: ->
    $('html').keydown @keydownHandler
  onBeforeDestroy: ->
    $('html').unbind 'keydown', @keydownHandler
  
    
module.exports = IsEscapeModal
