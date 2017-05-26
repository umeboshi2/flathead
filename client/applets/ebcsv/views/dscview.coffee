Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
marked = require 'marked'

BootstrapFormView = require 'tbirds/views/bsformview'
navigate_to_url = require 'tbirds/util/navigate-to-url'
{ form_group_input_div } = require 'tbirds/templates/forms'

AppChannel = Backbone.Radio.channel 'ebcsv'


class BaseFormDataView extends BootstrapFormView
  ui: ->
    data = {}
    for field of @form_data
      data[field] = "[name=\"#{field}\"]"
    return data
  updateModel: ->
    data = {}
    for field of @form_data
      data[field] = @ui[field].val()
    @model.set data

  onSuccess: (model) ->
    #console.log 'onSuccess called'
    navigate_to_url '#'

dsc_template = tc.renderable (model) ->
  tc.div '#edit-dsc-btn.btn.btn-default', 'Edit Description'
  tc.article '.document-view.content', ->
    tc.div '.body', ->
      tc.raw marked model.content
  

########################################
class DscView extends Backbone.Marionette.View
  template: dsc_template
  ui:
    edit_btn: '#edit-dsc-btn'
  events:
    'click @ui.edit_btn': 'edit_description'
  edit_description: ->
    navigate_to_url "#ebcsv/dsc/edit/#{@model.id}"
    
module.exports = DscView

