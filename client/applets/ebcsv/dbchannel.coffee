Backbone = require 'backbone'

{ make_dbchannel } = require 'tbirds/crud/basecrudchannel'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'ebcsv'

AuthModel = MainChannel.request 'main:app:AuthModel'
AuthCollection = MainChannel.request 'main:app:AuthCollection'

#apiroot = "/api/dev/booky"
apiroot = "/api/dev/bapi"
cfg_apipath = "#{apiroot}/ebcsvcfg"
dsc_apipath = "#{apiroot}/ebcsvdsc"

class SuperHeroList extends Backbone.Model
  url: '/assets/data/superheroes.json'

hero_list = new SuperHeroList
AppChannel.reply 'get-superheroes-model', ->
  hero_list

class BaseLocalStorageModel extends Backbone.Model
  initialize: () ->
    @fetch()
    @on 'change', @save, @
  fetch: () ->
    #console.log '===== FETCH FIRED LOADING LOCAL STORAGE ===='
    @set JSON.parse localStorage.getItem @id
  save: (attributes, options) ->
    #console.log '===== CHANGE FIRED SAVING LOCAL STORAGE ===='
    localStorage.setItem(@id, JSON.stringify(@toJSON()))
    #return $.ajax
    #  success: options.success
    #  error: options.error
  destroy: (options) ->
    #console.log '===== DESTROY LOCAL STORAGE ===='
    localStorage.removeItem @id
  isEmpty: () ->
    _.size @attributes <= 1



  
  
AppChannel.reply 'get-comic-image-urls', ->
  comic_image_urls = new BaseLocalStorageModel
    id: 'comic-image-urls'
  comic_image_urls.toJSON()

AppChannel.reply 'add-comic-image-url', (url, image_src) ->
  comic_image_urls = new BaseLocalStorageModel
    id: 'comic-image-urls'
  comic_image_urls.set url, image_src
  #comic_image_urls.save()
  
AppChannel.reply 'clear-comic-image-urls', ->
  comic_image_urls = new BaseLocalStorageModel
    id: 'comic-image-urls'
  comic_image_urls.destroy()
  #delete localStorage[comic_image_urls.id]
  console.log "localStorage", localStorage[comic_image_urls.id]
  
class EbConfigModel extends AuthModel
  urlRoot: cfg_apipath
  parse: (response, options) ->
    if typeof(response.content) is 'string'
      response.content = JSON.parse response.content
    super response, options
    
class EbConfigCollection extends AuthCollection
  url: cfg_apipath
  model: EbConfigModel

make_dbchannel AppChannel, 'ebcfg', EbConfigModel, EbConfigCollection


class EbDescModel extends AuthModel
  urlRoot: dsc_apipath

class EbDescCollection extends AuthCollection
  url: dsc_apipath
  model: EbDescModel

make_dbchannel AppChannel, 'ebdsc', EbDescModel, EbDescCollection

class ClzPage extends AuthModel
  urlRoot: "#{apiroot}/ebclzpage"
  parse: (response, options) ->
    if typeof(response.clzdata) is 'string'
      response.clzdata = JSON.parse response.clzdata
    super response, options

class ClzPageCollection extends AuthCollection
  url: "#{apiroot}/ebclzpage"
  model: ClzPage
  
make_dbchannel AppChannel, 'clzpage', ClzPage, ClzPageCollection


class ClzComic extends AuthModel
  urlRoot: "#{apiroot}/ebclzcomic"
  parse: (response, options) ->
    if typeof(response.content) is 'string'
      response.content = JSON.parse response.content
    super response, options

class ClzComicCollection extends AuthCollection
  url: "#{apiroot}/ebclzcomic"
  model: ClzComic
  
make_dbchannel AppChannel, 'clzcomic', ClzComic, ClzComicCollection

AppletLocals = {}
AppChannel.reply 'applet:local:get', (name) ->
  AppletLocals[name]

AppChannel.reply 'applet:local:set', (name, value) ->
  AppletLocals[name] = value
AppChannel.reply 'applet:local:delete', (name) ->
  delete AppletLocals[name]
  
  

current_csv_action = undefined
AppChannel.reply 'set-current-csv-action', (action) ->
  #current_csv_action = action
  AppChannel.request 'applet:local:set', 'currentCsvAction', action
AppChannel.reply 'get-current-csv-action', ->
  #current_csv_action
  AppChannel.request 'applet:local:get', 'currentCsvAction'
  
current_csv_cfg = undefined
AppChannel.reply 'set-current-csv-cfg', (cfg) ->
  #current_csv_cfg = cfg
  AppChannel.request 'applet:local:set', 'currentCsvCfg', cfg
AppChannel.reply 'get-current-csv-cfg', ->
  #current_csv_cfg
  AppChannel.request 'applet:local:get', 'currentCsvCfg'
  
current_csv_dsc = undefined
AppChannel.reply 'set-current-csv-dsc', (dsc) ->
  #current_csv_dsc = dsc
  AppChannel.request 'applet:local:set', 'currentCsvDsc', dsc
AppChannel.reply 'get-current-csv-dsc', ->
  #current_csv_dsc
  AppChannel.request 'applet:local:get', 'currentCsvDsc'

module.exports =
  EbConfigCollection: EbConfigCollection
  EbDescCollection: EbDescCollection
  ClzPageCollection: ClzPageCollection
  
