CollectionStatus = require './clzcollectionstatus'
bookshelf = require '../bookshelf'

module.exports = bookshelf.Model.extend
  tableName: 'ebcsv_clz_comics'
  hasTimestamps: true
  collectionStatus: ->
    @belongsTo CollectionStatus, 'list_id'
    
,
  jsonColumns: ['content']
