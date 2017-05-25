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
      connection:
        host: process.env.OPENSHIFT_POSTGRESQL_DB_HOST
        port: process.env.OPENSHIFT_POSTGRESQL_DB_PORT
        user: process.env.OPENSHIFT_POSTGRESQL_DB_USERNAME
        password: process.env.OPENSHIFT_POSTGRESQL_DB_PASSWORD
        database: process.env.PGDATABASE
      #connection: filename: "#{process.env.OPENSHIFT_DATA_DIR}flathead.sqlite"
      debug: false
    brand: 'Flathead'
    apipath: '/api/dev'
