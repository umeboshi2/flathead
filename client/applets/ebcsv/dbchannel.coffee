Backbone = require 'backbone'

{ make_dbchannel } = require 'tbirds/crud/basecrudchannel'

AppChannel = Backbone.Radio.channel 'ebcsv'

cfg_apipath = "/api/dev/booky/ebcsvcfg"
dsc_apipath = "/api/dev/booky/ebcsvdsc"
hero_apipath = "/api/dev/booky/ebcsvhero"

class EbConfigModel extends Backbone.Model
  urlRoot: cfg_apipath

class EbConfigCollection extends Backbone.Collection
  url: cfg_apipath
  model: EbConfigModel

make_dbchannel AppChannel, 'ebcfg', EbConfigModel, EbConfigCollection


class EbDescModel extends Backbone.Model
  urlRoot: dsc_apipath

class EbDescCollection extends Backbone.Collection
  url: dsc_apipath
  model: EbDescModel

make_dbchannel AppChannel, 'ebdsc', EbDescModel, EbDescCollection


module.exports =
  EbConfigCollection: EbConfigCollection
  EbDescCollection: EbDescCollection
  
