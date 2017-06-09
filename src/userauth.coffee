bcrypt = require 'bcryptjs'

_ = require 'underscore'
jwt = require 'jsonwebtoken'
passport = require 'passport'
passportJWT = require 'passport-jwt'

ExtractJwt = passportJWT.ExtractJwt
JwtStrategy = passportJWT.Strategy

# FIXME this is needed for passport strategy
# figure out how to use req.app.locals in passport
# strategy
#{ models } = require './kmodels'

jwtOptions =
  jwtFromRequest: ExtractJwt.fromAuthHeader()
  secretOrKey: 'FIXME-get-a-secret-key-from-config'
  passReqToCallback: true


users = [
  {
    id: 1
    name: 'admin'
    password: 'admin'
  }
  {
    id: 2
    name: 'test'
    password: 'test'
  }
]

strategy = new JwtStrategy jwtOptions, (req, jwt_payload, next) ->
  #console.log 'payload received', jwt_payload
  users = req.app.locals.models.User.collection()
  users.query
    where:
      uid: jwt_payload.uid
  .fetchOne().then (model) ->
    if model
      next null, model
    else
      next null, false



auth = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.redirect '/#frontdoor/login'

setup = (app) ->
  passport.use strategy
  app.use passport.initialize()

  app.get '/login', (req, res) ->
    res.redirect '/'
    return

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
      #console.log "Tpass", tuser.get('password')
      foo = model.compare req.body.password, password
      #foo = model.compare 'password', password
      #console.log "foo", foo
      foo.then (isValid) ->
        if isValid
          id = model.get 'id'
          console.log "ID IS", id
          payload =
            uid: model.get 'uid'
            username: model.get 'username'
          console.log "TOKEN PAYLOAD", payload
          token = jwt.sign payload, jwtOptions.secretOrKey
          res.json
            msg: 'ok'
            token: token
        else
          res.sendStatus 401
        
    app.get '/secret',
    passport.authenticate('jwt', session: false), (req, res) ->
      res.json message: 'Success! You can not see this without a token.'
    

module.exports =
  setup: setup
  auth: auth
  
