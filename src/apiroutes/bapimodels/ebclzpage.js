// Generated by CoffeeScript 1.11.0
var bookshelf;

bookshelf = require('../../endpoints/classes/database');

module.exports = bookshelf.Model.extend({
  tableName: 'ebcsv_clz_comic_pages'
}, {
  jsonColumns: ['clzdata']
});