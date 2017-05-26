HERODATA = require '../assets/data/superheroes'
table_name = 'ebcsv_superhero_categories'
exports.seed = (knex, Promise) ->
  knex(table_name).del()
  .then () ->
    knex(table_name).insert HERODATA.rows
