bookshelf = require '../bookshelf'

module.exports = bookshelf.Model.extend
  tableName: 'ebcsv_configs'
,
  jsonColumns: ['content']
  
