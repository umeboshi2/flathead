$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ MainController } = require 'tbirds/controllers'
ToolbarView = require 'tbirds/views/button-toolbar'
ShowInitialEmptyContent = require 'tbirds/behaviors/show-initial-empty'
SlideDownRegion = require 'tbirds/regions/slidedown'

navigate_to_url = require 'tbirds/util/navigate-to-url'
scroll_top_fast = require 'tbirds/util/scroll-top-fast'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'ebcsv'

toolbarEntries = [
  {
    id: 'main'
    label: 'Main View'
    url: '#ebcsv'
    icon: '.fa.fa-eye'
  }
  {
    id: 'localcomics'
    label: 'Local Comics'
    url: '#ebcsv/comics/local'
    icon: '.fa.fa-list'
  }
  {
    id: 'cfglist'
    label: 'Configs'
    url: '#ebcsv/cfg/list'
    icon: '.fa.fa-list'
  }
  {
    id: 'dsclist'
    label: 'Descriptions'
    url: '#ebcsv/dsc/list'
    icon: '.fa.fa-list'
  }
  {
    id: 'uploadxml'
    label: 'Upload CLZ/XML'
    url: '#ebcsv/xml/upload'
    icon: '.fa.fa-upload'
  }
  {
    id: 'mkcsv'
    label: 'Create CSV'
    url: '#ebcsv/csv/create'
    icon: '.fa.fa-cubes'
  }
  {
    id: 'cached'
    label: 'Cached Images'
    url: '#ebcsv/clzpage'
    icon: '.fa.fa-image'
  }
  ]

toolbarEntryCollection = new Backbone.Collection toolbarEntries
AppChannel.reply 'get-toolbar-entries', ->
  toolbarEntryCollection

button_style = "overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"

class EbCsvToolbar extends ToolbarView
  options:
    entryTemplate: tc.renderable (model) ->
      opts =
        style: button_style
      tc.span opts, ->
        tc.i model.icon
        tc.text " "
        tc.text model.label

module.exports = EbCsvToolbar

