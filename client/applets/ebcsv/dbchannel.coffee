_ = require 'underscore'
Backbone = require 'backbone'
DbCollection = require 'tbirds/dbcollection'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'ebcsv'

AuthModel = MainChannel.request 'main:app:AuthModel'
AuthCollection = MainChannel.request 'main:app:AuthCollection'

apiroot = "/api/dev/bapi"
cfg_apipath = "#{apiroot}/ebcsvcfg"
dsc_apipath = "#{apiroot}/ebcsvdsc"

defaultOptions =
  channelName: 'ebcsv'
  
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

dbcfg = new DbCollection _.extend defaultOptions,
  modelName: 'ebcfg'
  modelClass: EbConfigModel
  collectionClass: EbConfigCollection

class EbDescModel extends AuthModel
  urlRoot: dsc_apipath

class EbDescCollection extends AuthCollection
  url: dsc_apipath
  model: EbDescModel

dbdsc = new DbCollection _.extend defaultOptions,
  modelName: 'ebdsc'
  modelClass: EbDescModel
  collectionClass: EbDescCollection

class ClzPage extends AuthModel
  urlRoot: "#{apiroot}/ebclzpage"
  parse: (response, options) ->
    if typeof(response.clzdata) is 'string'
      response.clzdata = JSON.parse response.clzdata
    super response, options

class ClzPageCollection extends AuthCollection
  url: "#{apiroot}/ebclzpage"
  model: ClzPage

dbclzpage = new DbCollection _.extend defaultOptions,
  modelName: 'clzpage'
  modelClass: ClzPage
  collectionClass: ClzPageCollection
  
# get all except content
dbComicColumns = ['id', 'comic_id', 'list_id', 'bpcomicid',
  'bpseriesid', 'rare', 'publisher', 'releasedate',
  'seriesgroup', 'series', 'issue', 'issueext', 'quantity',
  'currentprice', 'url', 'image_src', 'created_at', 'updated_at']

AppChannel.reply 'dbComicColumns', ->
  dbComicColumns
  
class ClzComic extends AuthModel
  urlRoot: "#{apiroot}/ebclzcomic"
  parse: (response, options) ->
    if typeof(response.content) is 'string'
      response.content = JSON.parse response.content
    super response, options
  fetch: (options) ->
    # FIXME this is messy, do we need to go through this
    # trouble?  We hardly ever set fetch options on a
    # single model.
    options = options or {}
    options.data = options.data or {}
    if not options.data?.withRelated
      options.data.withRelated = ['collectionStatus']
    super options
  save: (attrs, options) ->
    if @has 'collectionStatus'
      @unset 'collectionStatus'
    super attrs, options
    
class ClzComicCollection extends AuthCollection
  url: "#{apiroot}/ebclzcomic"
  model: ClzComic
  fetch: (options) ->
    options = options or {}
    options.data = options.data or {}
    if not options.data?.withRelated
      options.data.withRelated = ['collectionStatus']
    super
    
dbclzcomic = new DbCollection _.extend defaultOptions,
  modelName: 'clzcomic'
  modelClass: ClzComic
  collectionClass: ClzComicCollection

class ClzCollectionStatus extends AuthModel
  urlRoot: "#{apiroot}/clzcollectionstatus"

class ClzCollectionStatusCollection extends AuthCollection
  url: "#{apiroot}/clzcollectionstatus"
  model: ClzCollectionStatus
  
dbclzcomic = new DbCollection _.extend defaultOptions,
  modelName: 'clzcollectionstatus'
  modelClass: ClzCollectionStatus
  collectionClass: ClzCollectionStatusCollection

AppletLocals = {}
AppChannel.reply 'locals:get', (name) ->
  AppletLocals[name]
AppChannel.reply 'locals:set', (name, value) ->
  AppletLocals[name] = value
AppChannel.reply 'locals:delete', (name) ->
  delete AppletLocals[name]
  
  
module.exports =
  EbConfigCollection: EbConfigCollection
  EbDescCollection: EbDescCollection
  ClzPageCollection: ClzPageCollection
  
