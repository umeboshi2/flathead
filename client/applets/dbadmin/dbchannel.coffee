Backbone = require 'backbone'

{ make_dbchannel } = require 'tbirds/crud/basecrudchannel'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'dbadmin'


AuthModel = MainChannel.request 'main:app:AuthModel'
AuthCollection = MainChannel.request 'main:app:AuthCollection'

apiroot = "/api/dev/bapi"
cfg_apipath = "#{apiroot}/ebcsvcfg"
dsc_apipath = "#{apiroot}/ebcsvdsc"
apipath = "/api/dev/booky/DbDoc"



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



class Document extends AuthModel
  urlRoot: apipath
  
class DocumentCollection extends AuthCollection
  url: apipath
  model: Document

make_dbchannel AppChannel, 'document', Document, DocumentCollection


todos_url = "/api/dev/bapi/fhtodos"

class Todo extends AuthModel
  urlRoot: todos_url
  defaults:
    completed: false
    

class TodoCollection extends AuthCollection
  url: todos_url
  model: Todo

make_dbchannel AppChannel, 'todo', Todo, TodoCollection


module.exports =
  DocumentCollection: DocumentCollection

