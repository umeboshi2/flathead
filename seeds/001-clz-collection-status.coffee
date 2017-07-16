tableName = 'clz_collection_status'
exports.seed = (knex, Promise) ->
  knex(tableName).del()
  .then () ->
    # Inserts seed entries
    knex(tableName).insert([
      {id: 1, name: 'not-in-collection'}
      {id: 2, name: 'wanted'}
      {id: 3, name: 'in-collection'}
      {id: 4, name: 'for-sale'}
      {id: 5, name: 'on-order'}
    ])
