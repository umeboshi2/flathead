bookshelf = require './endpoints/classes/database'

User = bookshelf.Model.extend
  tableName: 'users'
  bcrypt:
    field: 'password'
  posts: ->
    @hasMany Post


Post = bookshelf.Model.extend
  tableName: 'posts'
  comments: ->
    @hasMany Comment
    
Comment = bookshelf.Model.extend
  tableName: 'comments'

DbDoc = bookshelf.Model.extend
  tableName: 'kdocs'

GenObject = bookshelf.Model.extend
  tableName: 'miscobjects'
,
  jsonColumns: ['content']
  

EbCsvConfig = bookshelf.Model.extend
  tableName: 'ebcsv_configs'
,
  jsonColumns: ['content']
  

EbCsvDescription = bookshelf.Model.extend
  tableName: 'ebcsv_descriptions'

EbCsvSuperhero = bookshelf.Model.extend
  tableName: 'ebcsv_superhero_categories'



models =
  User: User
  Post: Post
  Comment: Comment
  DbDoc: DbDoc
  GenObject: GenObject
  EbCsvConfig: EbCsvConfig
  EbCsvDescription: EbCsvDescription
  EbCsvSuperhero: EbCsvSuperhero
  
module.exports =
  knex: bookshelf.knex
  bookshelf: bookshelf
  models: models