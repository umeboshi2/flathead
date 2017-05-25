path = require 'path'
gzipStatic = require 'connect-gzip-static'

set_clientjs_route = (app) ->
  UseMiddleware = false or process.env.__DEV_MIDDLEWARE__ is 'true'
  if UseMiddleware
    #require 'coffee-script/register'
    webpack = require 'webpack'
    middleware = require 'webpack-dev-middleware'
    config = require '../webpack.config'
    compiler = webpack config
    app.use middleware compiler,
      #publicPath: config.output.publicPath
      # FIXME using absolute path?
      publicPath: '/build/'
      stats:
        colors: true
        modules: false
        chunks: true
        #reasons: true
        maxModules: 9999
        progress: true
    console.log "Using webpack middleware"
  else
    app.use '/build', gzipStatic(path.join __dirname, '../build')

module.exports = set_clientjs_route


