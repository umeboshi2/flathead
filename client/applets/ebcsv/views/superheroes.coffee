Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'
capitalize = require 'tbirds/util/capitalize'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'



age_context =
  platinum: 'danger'
  golden: 'danger'
  silver: 'warning'
  bronze: 'info'
  copper: 'success'
  modern: 'primary'
  apailofair: 'default'




########################################
# Templates
########################################

base_item_template = (name, route_name) ->
  tc.renderable (model) ->
    item_btn = ".btn.btn-default.btn-xs"
    tc.li ".list-group-item.#{name}-item", ->
      tc.span ".label.label-#{age_context[model.age]}", model.age
      tc.span "  #{model.superhero}"
      
base_list_template = (name) ->
  tc.renderable (model) ->
    tc.div '.listview-header', ->
      tc.text capitalize name
    tc.hr()
    tc.ul "##{name}-container.list-group"


########################################
Views = require './basecrudviews'

ItemTemplate = base_item_template 'ebhero', 'ebcsv'
        
ListTemplate = base_list_template 'ebhero'

class ItemView extends Views.BaseItemView
  route_name: 'ebcsv'
  template: ItemTemplate
  item_type: 'ebhero'
  

  
class ListView extends Views.BaseListView
  route_name: 'ebcsv'
  childView: ItemView
  template: ListTemplate
  childViewContainer: '#ebhero-container'
  item_type: 'ebhero'
    
    
module.exports = ListView

