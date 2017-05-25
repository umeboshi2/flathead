Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
marked = require 'marked'

BootstrapFormView = require 'tbirds/views/bsformview'
navigate_to_url = require 'tbirds/util/navigate-to-url'
{ form_group_input_div } = require 'tbirds/templates/forms'

AppChannel = Backbone.Radio.channel 'ebcsv'

ReqFieldNames = AppChannel.request 'csv-req-fieldnames'
OptFieldNames = AppChannel.request 'csv-opt-fieldnames'

mkInputData = (field, label, placeholder) ->
  input_id: "input_#{field}"
  label: label
  input_attributes:
    name: field
    placeholder: placeholder

csvfields_form_data =
  format: mkInputData 'format', 'Format', 'FixedPrice'
  location: mkInputData 'location', 'Location', '90210'
  returnsacceptedoption: mkInputData 'returnsacceptedoption',
  'Returns Accepted Option', 'ReturnsAccepted'
  duration: mkInputData 'duration', 'Duration', 'GTC'
  quantity: mkInputData 'quantity', 'Quantity', '1'
  startprice: mkInputData 'startprice', 'Start Price', '1.25'
  dispatchtimemax: mkInputData 'dispatchtimemax', 'Dispatch Time Max', '2'
  conditionid: mkInputData 'conditionid', 'Condition ID', '0'
  postalcode: mkInputData 'postalcode', 'Postal Code', '90210'
  paymentprofilename: mkInputData 'paymentprofilename',
  'Payment Profile Name', 'PayNowPal'
  returnprofilename: mkInputData 'returnprofilename',
  'Return Profile Name', 'Return30ExChangeReStock20'
  shippingprofilename: mkInputData 'shippingprofilename',
  'Shipping Profile Name', 'Raw Comic Shipments'
  scheduletime: mkInputData 'scheduletime', 'Listing Delay Time', '14d'
  
make_form_input = tc.renderable (field, fdata, settings) ->
  idata = fdata[field]
  value = settings[field]
  if value? and value isnt ''
    console.log "Value is", value
    idata.input_attributes.value = settings[field]
  else
    console.log 'use placeholder', field, idata
    idata.input_attributes.value = idata.input_attributes.placeholder
  form_group_input_div idata

csvfields_form = tc.renderable (settings) ->
  tc.div '.panel.panel-default', ->
    tc.div '.panel-heading', 'Required Fields'
    tc.div '.panel-content', ->
      for field in ReqFieldNames
        make_form_input field, csvfields_form_data, settings
  tc.div '.panel.panel-default', ->
    tc.div '.panel-heading', 'Optional Fields'
    tc.div '.panel-content', ->
      for field in OptFieldNames
        make_form_input field, csvfields_form_data, settings
  tc.input '.btn.btn-default.btn-xs', type:'submit', value:'Submit'

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

########################################
class ReqFieldsFormView extends BaseFormDataView
  template: csvfields_form
  form_data: csvfields_form_data
  createModel: ->
    AppChannel.request 'get_ebcsv_settings'
    
module.exports = ReqFieldsFormView

