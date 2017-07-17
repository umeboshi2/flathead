var CollectionStatus, bookshelf;

CollectionStatus = require('./clzcollectionstatus');

bookshelf = require('../bookshelf');

module.exports = bookshelf.Model.extend({
  tableName: 'ebcsv_clz_comics',
  hasTimestamps: true,
  collectionStatus: function() {
    return this.belongsTo(CollectionStatus, 'list_id');
  }
}, {
  jsonColumns: ['content']
});

//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZWJjbHpjb21pYy5qcyIsInNvdXJjZXMiOlsiZWJjbHpjb21pYy5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUEsSUFBQTs7QUFBQSxnQkFBQSxHQUFtQixPQUFBLENBQVEsdUJBQVI7O0FBQ25CLFNBQUEsR0FBWSxPQUFBLENBQVEsY0FBUjs7QUFFWixNQUFNLENBQUMsT0FBUCxHQUFpQixTQUFTLENBQUMsS0FBSyxDQUFDLE1BQWhCLENBQ2Y7RUFBQSxTQUFBLEVBQVcsa0JBQVg7RUFDQSxhQUFBLEVBQWUsSUFEZjtFQUVBLGdCQUFBLEVBQWtCLFNBQUE7V0FDaEIsSUFBQyxDQUFBLFNBQUQsQ0FBVyxnQkFBWCxFQUE2QixTQUE3QjtFQURnQixDQUZsQjtDQURlLEVBT2Y7RUFBQSxXQUFBLEVBQWEsQ0FBQyxTQUFELENBQWI7Q0FQZSIsInNvdXJjZXNDb250ZW50IjpbIkNvbGxlY3Rpb25TdGF0dXMgPSByZXF1aXJlICcuL2NsemNvbGxlY3Rpb25zdGF0dXMnXG5ib29rc2hlbGYgPSByZXF1aXJlICcuLi9ib29rc2hlbGYnXG5cbm1vZHVsZS5leHBvcnRzID0gYm9va3NoZWxmLk1vZGVsLmV4dGVuZFxuICB0YWJsZU5hbWU6ICdlYmNzdl9jbHpfY29taWNzJ1xuICBoYXNUaW1lc3RhbXBzOiB0cnVlXG4gIGNvbGxlY3Rpb25TdGF0dXM6IC0+XG4gICAgQGJlbG9uZ3NUbyBDb2xsZWN0aW9uU3RhdHVzLCAnbGlzdF9pZCdcbiAgICBcbixcbiAganNvbkNvbHVtbnM6IFsnY29udGVudCddXG4iXX0=
