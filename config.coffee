path = require 'path'
_ = require 'underscore'

dbfile = path.join __dirname, '/flathead.sqlite'
#postgresql://$OPENSHIFT_POSTGRESQL_DB_HOST:$OPENSHIFT_POSTGRESQL_DB_PORT
module.exports =
  development:
    database:
      client: 'sqlite3'
      connection: filename: dbfile
      debug: false
    brand: 'Flathead'
    apipath: '/api/dev'
  production:
    database:
      client: 'pg'
      #connection: filename: "#{process.env.OPENSHIFT_DATA_DIR}flathead.sqlite"
      connection: process.env.OPENSHIFT_POSTGRESQL_DB_URL
      debug: false
    brand: 'Flathead'
    apipath: '/api/dev'
