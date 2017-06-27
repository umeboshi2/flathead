Backbone = require 'backbone'
imagesLoaded = require 'imagesloaded'

AppChannel = Backbone.Radio.channel 'ebcsv'

current_masonry_layout = undefined
AppChannel.reply 'set-masonry-layout', (layout) ->
  current_masonry_layout = layout
  
AppChannel.reply 'reload-layout', ->
  items = $ '.item'
  imagesLoaded items, ->
    current_masonry_layout.reloadItems()
    current_masonry_layout.layout()

