exports.up = (knex, Promise) ->
  Promise.all [
    knex.schema.createTable('comic_photo_names', (t) ->
      t.increments('id').primary()
      t.text('name').unique()
      )
  ]
  


exports.down = (knex, Promise) ->
  Promise.all [
    knex.schema.dropTable 'comic_photo_names'
  ]

