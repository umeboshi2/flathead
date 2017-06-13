bcrypt = require 'bcryptjs'

_ = require 'underscore'
jwt = require 'jsonwebtoken'

jwtAuth = require 'express-jwt'

#auth = (req, res, next) ->
#  if req.isAuthenticated()
#    next()
#  else
#    res.redirect '/#frontdoor/login'

auth = (req, res, next) ->
  config = req.app.locals.config
  secret = config.jwtOptions.secret
  jwtAuth secret: secret
  next()
  
  
setup = (app) ->
  config = app.locals.config
  jwtOptions = config.jwtOptions
  authOpts = secret: jwtOptions.secret
  app.get '/login', (req, res) ->
    res.redirect '/'

  app.get '/admin', jwtAuth authOpts, (req, res) ->
    console.log "Success!"
    res.redirect '/'

  app.post '/login', (req, res) ->
    console.log "req.body", req.body
    name = req.body.username
    password = req.body.password
    #tuser = new req.app.locals.models.User.forge(password:password)
    users = req.app.locals.models.User.collection()
    users.query
      where:
        username:name
    .fetchOne().then (model) ->
      console.log "MODEL", model
      if model is null
        res.sendStatus 401
        return
      password = model.get 'password'
      console.log "password", password
      model.compare req.body.password, password
      .then (isValid) ->
        if isValid
          id = model.get 'id'
          console.log "ID IS", id
          payload =
            uid: model.get 'uid'
            username: model.get 'username'
          console.log "TOKEN PAYLOAD", payload
          token = jwt.sign payload, jwtOptions.secret, expiresIn:'10m'
          res.json
            msg: 'ok'
            token: token
        else
          res.sendStatus 401
        

module.exports =
  setup: setup
  auth: auth
  
