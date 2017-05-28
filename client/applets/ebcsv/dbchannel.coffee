Backbone = require 'backbone'

{ make_dbchannel } = require 'tbirds/crud/basecrudchannel'

AppChannel = Backbone.Radio.channel 'ebcsv'

apiroot = "/api/dev/booky"
cfg_apipath = "#{apiroot}/ebcsvcfg"
dsc_apipath = "#{apiroot}/ebcsvdsc"
hero_apipath = "#{apiroot}/ebcsvhero"

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

class ClzPage extends Backbone.Model
  urlRoot: "#{apiroot}/ebclzpage"

class ClzPageCollection extends Backbone.Collection
  url: "#{apiroot}/ebclzpage"
  model: ClzPage
  
make_dbchannel AppChannel, 'clzpage', ClzPage, ClzPageCollection

module.exports =
  EbConfigCollection: EbConfigCollection
  EbDescCollection: EbDescCollection
  ClzPageCollection: ClzPageCollection
  
