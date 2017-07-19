exports.up = (knex, Promise) ->
  Promise.all [
    knex.schema.createTable('clz_collection_status', (t) ->
      t.increments('id').primary()
      t.text('name').unique()
      )
    knex.schema.createTable('ebcsv_clz_comics', (t) ->
      t.increments('id').primary()
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
    knex.schema.createTable('ebcomics_workspace', (t) ->
      t.increments('id').primary()
      t.integer('comic_id').references('comic_id').inTable('ebcsv_clz_comics').unique()
      t.text('name')
      t.timestamps()
      return
    )
    knex.schema.createTable('general_uploads', (table) ->
      table.integer('id').primary()
      table.text 'fieldname'
      table.text 'originalname'
      table.text 'encoding'
      table.text 'mimetype'
      table.text 'destination'
      table.text 'filename'
      table.text 'path'
      table.bigint 'size'
      table.timestamps()
      return
    )
    knex.schema.createTable('comic_photos', (table) ->
      table.integer('id').primary()
      table.integer('comic_id').references('comic_id').inTable('ebcsv_clz_comics').unique()
      table.text 'name'
      table.text 'filename'
      table.text 'encoding'
      table.text 'mimetype'
      table.timestamps()
      return
    )
  ]
  


exports.down = (knex, Promise) ->
  Promise.all [
    knex.schema.dropTable 'clz_collection_status'
    knex.schema.dropTable 'ebcsv_clz_comics'
    knex.schema.dropTable 'ebcomics_workspace'
    knex.schema.dropTable 'general_uploads'
    knex.schema.dropTable 'comic_photos'
  ]

