Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

make_field_input_ui = require 'tbirds/util/make-field-input-ui'
navigate_to_url = require 'tbirds/util/navigate-to-url'

{ form_group_input_div } = require 'tbirds/templates/forms'
BootstrapFormView = require 'tbirds/views/bsformview'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

ghost_login_form =  tc.renderable (user) ->
  form_group_input_div
    input_id: 'input_username'
    label: 'User Name'
    input_attributes:
      name: 'username'
      placeholder: 'User Name'
  form_group_input_div
    input_id: 'input_password'
    label: 'Password'
    input_attributes:
      name: 'password'
      type: 'password'
      placeholder: 'Type your password here....'
  tc.input '.btn.btn-default', type:'submit', value:'login'
  tc.div '.spinner.fa.fa-spinner.fa-spin'


class LoginView extends BootstrapFormView
  template: ghost_login_form
  fieldList: ['username', 'password']
  ui: ->
    uiobject = make_field_input_ui @fieldList
    return uiobject

  createModel: ->
    new Backbone.Model

  updateModel: ->
    console.log 'updateModel called'
    @model.set 'username', @ui.username.val()
    @model.set 'password', @ui.password.val()

  saveModel: ->
    username  = @model.get 'username'
    password = @model.get 'password'
    if __DEV__
      config = require('../../../config').development
      username = config.adminUser.username
      password = config.adminUser.password
    xhr = $.ajax
      url: '/login'
      type: 'POST'
      data:
        username: username
        password: password
      dataType: 'json'
      success: (response) =>
        #response.time = time
        #@save response
        #@trigger 'refresh', response, this
        console.log "Success!", response
        token = response.token
        MainChannel.request 'main:app:set-auth-token', token
        @trigger 'save:form:success', @model
        
      error: (response) =>
        console.log "error", response
        #console.log response.responseJSON
        #for error in response.responseJSON.errors
        #  MessageChannel.request 'warning', error.message
        MessageChannel.request 'warning', response.responseText
        @trigger 'save:form:failure', @model
        
    console.log "returning xhr", xhr
    
  saveModelOrig: ->
    auth = MainChannel.request 'main:app:ghostauth'
    console.log auth
    username  = @model.get 'username'
    password = @model.get 'password'
    res = auth.access username, password
    res.error =>
      @trigger 'save:form:failure', @model
    res.success =>
      @trigger 'save:form:success', @model
      
  onSuccess: ->
    # FIXME start reloading the child apps
    # that recognize users
    navigate_to_url '/'
    
     
    
module.exports = LoginView
