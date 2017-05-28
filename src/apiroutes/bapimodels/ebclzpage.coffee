bookshelf = require '../../endpoints/classes/database'

module.exports = bookshelf.Model.extend
  tableName: 'ebcsv_clz_comic_pages'
,
  jsonColumns: ['clzdata']
