Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

navigate_to_url = require 'tbirds/util/navigate-to-url'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'sofi'

########################################
Templates = require 'tbirds/templates/basecrud'

Views = require './basecrudviews'

ItemTemplate = Templates.base_item_template 'ebdsc', 'sofi'
        
ListTemplate = Templates.base_list_template 'ebdsc'

class ItemView extends Views.BaseItemView
  route_name: 'sofi'
  template: ItemTemplate
  item_type: 'ebdsc'
  

  
class ListView extends Views.BaseListView
  route_name: 'sofi'
  childView: ItemView
  template: ListTemplate
  childViewContainer: '#ebdsc-container'
  item_type: 'ebdsc'
    
    
module.exports = ListView


