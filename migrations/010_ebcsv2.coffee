exports.up = (knex, Promise) ->
  Promise.all [
    knex.schema.createTable('clz_collection_status', (t) ->
      t.increments('id').primary()
      t.text('name').unique()
      )
    knex.schema.createTable('ebcsv_clz_comics', (t) ->
      t.integer('id').primary()
      t.integer('comic_id').unique()
      # I don't know what this is
      t.integer 'index'
      # this is collection status id
      t.integer('list_id').references('id').inTable('clz_collection_status')
      # I don't know what bp stuff is, but we put it in database
      t.integer 'bpcomicid'
      t.integer 'bpseriesid'
      # these seem to be reasonable fields to grab from xml
      t.boolean('rare').defaultTo(false)
      t.text 'publisher'
      t.date 'releasedate'
      t.text('seriesgroup').defaultTo('UNGROUPED')
      t.text 'series'
      t.integer 'issue'
      t.text 'issueext'
      t.integer 'quantity'
      t.float('currentprice').defaultTo(0.0)
      t.text('url').defaultTo('UNAVAILABLE')
      t.text('image_src').defaultTo('UNSET')
      # parsed xml object
      t.text 'content'
      t.timestamps()
      return
    )
    knex.schema.createTable('ebcsv_comic_data', (t) ->
      t.increments('id').primary()
      t.text('name').unique()
      t.text 'content'
      # this is usually stock image
      t.text 'image_src'
      # parsed xml object
      t.text 'clzdata'
      # hosted image
      t.boolean('stock_image').defaultTo(false)
      t.timestamps()
      return
    )
  ]
  


exports.down = (knex, Promise) ->
  Promise.all [
    knex.schema.dropTable 'ebcsv_cl'
    knex.schema.dropTable 'ebcsv_comic_data'
  ]

