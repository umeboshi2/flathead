path = require 'path'
_ = require 'underscore'

dbfile = path.join __dirname, '/flathead.sqlite'

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
      client: 'sqlite3'
      connection: filename: "#{process.env.OPENSHIFT_DATA_DIR}flathead.sqlite"
      debug: false
    brand: 'Flathead'
    apipath: '/api/dev'
