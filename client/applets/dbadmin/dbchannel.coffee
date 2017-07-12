_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

DbCollection = require 'tbirds/dbcollection'
MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'dbadmin'


AuthModel = MainChannel.request 'main:app:AuthModel'
AuthCollection = MainChannel.request 'main:app:AuthCollection'

apiroot = "/api/dev/bapi"
cfg_apipath = "#{apiroot}/ebcsvcfg"
dsc_apipath = "#{apiroot}/ebcsvdsc"

defaultOptions =
  channelName: 'dbadmin'
  
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

docpath = "/api/dev/booky/DbDoc"

class Document extends AuthModel
  urlRoot: docpath
  
class DocumentCollection extends AuthCollection
  url: docpath
  model: Document

dbdoc = new DbCollection _.extend defaultOptions,
  modelName: 'document'
  modelClass: Document
  collectionClass: DocumentCollection

todos_url = "/api/dev/bapi/fhtodos"

class Todo extends AuthModel
  urlRoot: todos_url
  defaults:
    completed: false
    

class TodoCollection extends AuthCollection
  url: todos_url
  model: Todo

dbtodo = new DbCollection _.extend defaultOptions,
  modelName: 'todo'
  modelClass: Todo
  collectionClass: TodoCollection


module.exports =
  DocumentCollection: DocumentCollection

