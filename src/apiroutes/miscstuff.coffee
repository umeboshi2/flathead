fs = require 'fs'
path = require 'path'

_ = require 'underscore'
Promise = require 'bluebird'
express = require 'express'

router = express.Router()


multer = require 'multer'
storage = multer.diskStorage
  destination: (req, file, cb) ->
    cb null, "#{process.env.OPENSHIFT_DATA_DIR}uploads"
  filename: (req, file, cb) ->
    cb null, file.originalname
    
upload = multer
  #dest: 'uploads/'
  storage: storage
{ get_models } = require './common'


#router.use hasUserAuth

router.get '/all-models', (req, res) ->
  get_models req, res
  .then ->
    res.json res.locals.models

router.post '/upload-photo', upload.single('comicphoto'), (req, res) ->
  data =
    comic_id: req.body.comic_id
    name: req.body.name
    filename: req.file.filename
    encoding: req.file.encoding
    mimetype: req.file.mimetype
  model = new res.app.locals.bsmodels.comicphoto data
  model.save()
  .then (result) ->
    # successful create gets a 201 status
    res.status 201
    # and a location header pointing to new object
    res.header 'Location', "/fake/path/to/#{result.id}"
    res.json result
  
router.post '/upload-photos', upload.array('comicphoto', 12), (req, res) ->
  console.log req.file
  model = new res.app.locals.bsmodels.uploads
  #res.app.locals.bsmodels.uploads.bulkCreate req.files
  #.then ->
  #  res.json
  #    result: 'success'
  #    data: req.
  console.log "FILES", req.files
  res.json result:'something happened'

router.get '/unattached-comics', (req, res) ->
  knex = res.app.locals.knex
  wstable = 'ebcomics_workspace'
  ctable = 'ebcsv_clz_comics'
  wscomics = knex.table(wstable).select('comic_id')
  wscomics = knex.select('comic_id').from(wscomics)
  wscomics = knex.table(wstable).select('comic_id')
  comics = knex.select('*').from(ctable).whereNotIn('comic_id', wscomics)
  comics.then (results) ->
    data =
      total: results.length
      items: results
    res.json data
  

module.exports = router
