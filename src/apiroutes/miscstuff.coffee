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

router.post '/upload/photo', upload.single('comicphoto'), (req, res) ->
  
router.post '/upload-photos', upload.array('zathras', 12), (req, res) ->
  console.log req.file
  model = new res.app.locals.bsmodels.uploads
  #res.app.locals.bsmodels.uploads.bulkCreate req.files
  #.then ->
  #  res.json
  #    result: 'success'
  #    data: req.
  console.log "FILES", req.files
  res.json result:'something happened'

module.exports = router
