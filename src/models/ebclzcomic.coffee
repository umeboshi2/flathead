bookshelf = require '../bookshelf'

module.exports = bookshelf.Model.extend
  tableName: 'ebcsv_clz_comics'
  hasTimestamps: true
,
  jsonColumns: ['content']
