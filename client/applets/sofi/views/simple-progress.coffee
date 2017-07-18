$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

parseReleaseDate = require '../ebutils/parse-releasedate'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

class ProgressModel extends Backbone.Model
  defaults:
    valuemin: 0
    valuemax: 100
    valuenow: 0

class ProgressView extends Marionette.View
  template: tc.renderable (model) ->
    tc.div '.progress', ->
      aria =
        valuemin: model.valuemin
        valuemax: model.valuemax
        valuenow: model.valuenow
      width = Math.floor model.valuenow / model.valuemax * 100 + 0.5
      tc.div '.progress-bar.progress-bar-striped',
      #role:'progressbar', aria: aria,
      role:'progressbar',
      style:"width: #{width}%", ->
        tc.span style:"color:black;",
        "#{model.valuenow} of #{model.valuemax}."
  modelEvents:
    'change': 'render'
    
    
module.exports =
  ProgressModel: ProgressModel
  ProgressView: ProgressView
  


