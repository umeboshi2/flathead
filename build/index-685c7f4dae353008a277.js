webpackJsonp([8],{"4svf":function(e,a,s){var t,o,r,n,l,i,p,c,u,b=function(e,a){function s(){this.constructor=e}for(var t in a)d.call(a,t)&&(e[t]=a[t]);return s.prototype=a.prototype,e.prototype=new s,e.__super__=a.prototype,e},d={}.hasOwnProperty;t=s("aGLy"),l=s("y11e"),u=s("2mEY"),i=s("X484"),s("qYnM"),c=s("7YgM"),r=s("H97n"),n=t.Radio.channel("global"),t.Radio.channel("messages"),o=function(e){function a(){return a.__super__.constructor.apply(this,arguments)}return b(a,e),a.prototype.template=u.renderable(function(e){return u.div("Version: "+e.version)}),a}(l.View),p=new i({appConfig:r}),p.on("before:start",function(){var e;return e=n.request("main:app:get-theme"),e=e||"vanilla",n.request("main:app:switch-theme",e)}),p.on("start",function(){var e,a,s;return a=new t.Model(c),s=new o({model:a}),e=p.getView().getRegion("footer"),e.show(s)}),n.request("main:app:route"),p.start(),e.exports=p},"7YgM":function(e,a){e.exports={name:"flathead",version:"0.0.20",description:"web app...",main:"start.js",scripts:{start:"node server.js",test:'echo "Error: no test specified" && exit 1'},repository:{type:"git",url:"git+https://github.com/umeboshi2/flathead.git"},keywords:["comics","ebay"],author:"Joseph Rawson",license:"UNLICENSED",bugs:{url:"https://github.com/umeboshi2/flathead/issues"},homepage:"https://github.com/umeboshi2/flathead#readme",devDependencies:{"amd-define-factory-patcher-loader":"^1.0.0","applet-bumblr":"umeboshi2/applet-bumblr",backbone:"^1.3.3","backbone-jsonapi":"namely/backbone-jsonapi","backbone.declarative.views":"^4.1.1","backbone.marionette":"^3.1.0","backbone.paginator":"^2.0.5","backbone.radio":"^2.0.0","backbone.validation":"^0.7.1",bootstrap:"^3.3.7","bootstrap-fileinput":"^4.3.6",brace:"^0.10.0","chunk-manifest-webpack-plugin":"^1.0.0","clean-webpack-plugin":"^0.1.15","coffee-loader":"^0.7.2","compression-webpack-plugin":"^0.3.2","css-loader":"^0.26.2",dateformat:"^2.0.0","editable-table":"^1.0.3",eslint:"^3.16.1","eslint-plugin-jsx-a11y":"^2.2.3","eslint-plugin-react":"^6.10.0","exports-loader":"^0.6.3","expose-loader":"^0.7.3","extract-text-webpack-plugin":"^2.0.0","file-loader":"^0.10.0",fullcalendar:"^3.2.0",graze:"^2.3.0",gulp:"^3.9.1","gulp-coffee":"^2.3.3","gulp-compass":"^2.1.0","gulp-concat":"^2.6.1","gulp-nodemon":"^2.2.1","gulp-size":"^2.1.0","gulp-sourcemaps":"^2.4.1","gulp-uglify":"^2.0.1","gulp-util":"^3.0.8",handlebars:"^4.0.10",imagesloaded:"^4.1.1","imports-loader":"^0.7.0",jquery:"^2.2.4","jquery-ui":"^1.12.1","jquery.json-viewer":"^1.1.0",js2coffee:"^2.2.0","jwt-decode":"^2.2.0",leaflet:"^1.0.3",lovefield:"^2.1.12","marionette.toolkit":"^3.1.0",marked:"^0.3.6","masonry-layout":"^4.1.1",minimist:"^1.2.0","node-sass":"^4.5.0",octokat:"^0.6.2","raw-loader":"^0.5.1","resolve-url-loader":"^2.0.0","sass-loader":"^6.0.2",shelljs:"^0.7.6","stats-webpack-plugin":"^0.4.3","style-loader":"^0.13.1",tbirds:"^0.3.3","url-loader":"^0.5.7",webpack:"^2.2.1","webpack-dev-middleware":"^1.10.0","webpack-dev-server":"^2.3.0","webpack-manifest-plugin":"^1.1.0","xml2js-parseonly":"umeboshi2/node-xml2js"},dependencies:{bcryptjs:"^2.4.3",bluebird:"^3.5.0","body-parser":"^1.17.0",bookshelf:"^0.10.3","bookshelf-api":"^1.7.1","bookshelf-bcrypt":"umeboshi2/bookshelf-bcrypt","bookshelf-json-columns":"^2.1.0","bookshelf-jsonapi-params":"^0.6.2","coffee-script":"^1.12.4","connect-gzip-static":"^2.0.1","cookie-parser":"^1.4.3",cors:"^2.8.1",endpoints:"^0.9.2",express:"^4.15.0","express-http-proxy":"^1.0.3","express-https-redirect":"^1.0.0","express-jwt":"^5.1.0","express-routebuilder":"^2.1.0","express-session":"^1.15.1","fantasy-database":"endpoints/fantasy-database",install:"^0.8.7","js-beautify":"^1.6.9","json-view":"^0.3.0","jsonapi-mapper":"^1.0.0-beta.11","jsonapi-serializer":"^3.4.2",jsonwebtoken:"^7.3.0",knex:"^0.12.7",morgan:"^1.8.1",ms:"^0.7.2",multer:"^1.3.0","node-gyp":"^3.6.1","node-pre-gyp":"^0.6.34",npm:"^4.4.1",passport:"^0.3.2","passport-jwt":"^2.2.1",pg:"^6.2.3",qs:"^6.3.1",request:"^2.80.0","serve-favicon":"^2.3.2",sqlite3:"^3.1.8",teacup:"^2.0.0",underscore:"^1.8.3"}}},H97n:function(e,a,s){var t,o,r;t=s("qF/v"),t.userMenuApp=s("TN+8"),t.hasUser=!0,t.brand.label="Flathead",t.brand.url="#",r={label:"Misc Applets",menu:[{label:"Themes",url:"#frontdoor/themes"},{label:"Ebcsv",url:"#ebcsv"},{label:"Bumblr",url:"#bumblr"},{label:"Hubby",url:"#hubby"}]},o={label:"Ebcsv",menu:[{label:"Main View",url:"#ebcsv"},{label:"List Configs",url:"#ebcsv/cfg/list"},{label:"List Descriptions",url:"#ebcsv/dsc/list"},{label:"Upload Comic XML",url:"#ebcsv/xml/upload"},{label:"Create CSV",url:"#ebcsv/csv/create"},{label:"Create New Config",url:"#ebcsv/cfg/add"}]},t.navbarEntries=[o,r],e.exports=t},qYnM:function(e,a,s){var t,o,r;t=s("4kSj"),o=s("aGLy"),s("gNGx"),s("IS1s"),s("Oo1E"),r=o.Radio.channel("global"),o.Radio.channel("messages"),r.reply("main:app:switch-theme",function(e){var a,s;return a="assets/stylesheets/bootstrap-"+e+".css",s=t('head link[href^="assets/stylesheets/bootstrap-"]'),s.attr("href",a)}),r.reply("main:app:set-theme",function(e){return localStorage.setItem("main-theme",e)}),r.reply("main:app:get-theme",function(){return localStorage.getItem("main-theme")}),e.exports={}}},["4svf"]);