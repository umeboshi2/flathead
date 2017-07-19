bookshelf = require './bookshelf'

clzcollectionstatus = bookshelf.Model.extend
  tableName: 'clz_collection_status'

ebclzcomic = bookshelf.Model.extend
  tableName: 'ebcsv_clz_comics'
  hasTimestamps: true
  collectionStatus: ->
    @belongsTo clzcollectionstatus, 'list_id'
  photos: ->
    @hasMany comicphoto, 'comic_id', 'comic_id'
,
  jsonColumns: ['content']

ebclzpage = bookshelf.Model.extend
  tableName: 'ebcsv_clz_comic_pages'
,
  jsonColumns: ['clzdata']

ebcomicworkspace = bookshelf.Model.extend
  tableName: 'ebcomics_workspace'
  hasTimestamps: true
  comic: ->
    @belongsTo ebclzcomic, 'comic_id'

ebcsvcfg = bookshelf.Model.extend
  tableName: 'ebcsv_configs'
  hasTimestamps: true
,
  jsonColumns: ['content']
  
ebcsvdsc = bookshelf.Model.extend
  tableName: 'ebcsv_descriptions'
  hasTimestamps: true

fhtodos = bookshelf.Model.extend
  tableName: 'flathead_todos'
  hasTimestamps: true

uploads = bookshelf.Model.extend
  tableName: 'general_uploads'
  hasTimestamps: true

comicphoto = bookshelf.Model.extend
  tableName: 'comic_photos'
  hasTimestamps: true
  comic: ->
    @belongsTo ebclzcomic, 'comic_id'
  
yadayada = bookshelf.Model.extend
  tableName: 'flathead_todos'
  hasTimestamps: true



module.exports =
  clzcollectionstatus: clzcollectionstatus
  ebclzcomic: ebclzcomic
  ebclzpage: ebclzpage
  ebcomicworkspace: ebcomicworkspace
  ebcsvcfg: ebcsvcfg
  ebcsvdsc: ebcsvdsc
  fhtodos: fhtodos
  uploads: uploads
  comicphoto: comicphoto
  yadayada: yadayada
