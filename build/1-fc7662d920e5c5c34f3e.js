webpackJsonp([1],{"9w6x":function(t,e){t.exports=function(){return window.scrollTo(0,0)}},EWhg:function(t,e,n){var o,r,u,i,c,s=function(t,e){function n(){this.constructor=t}for(var o in e)p.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},p={}.hasOwnProperty;r=n("GXmR").MainController,Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),i=Backbone.Radio.channel("resources"),c=n("iuxk").ToolbarAppletLayout,o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.layoutClass=c,e.prototype.setup_layout_if_needed=function(){return e.__super__.setup_layout_if_needed.call(this)},e.prototype.collection=i.request("document-collection"),e.prototype.list_pages=function(){return this.setup_layout_if_needed(),console.log("List Pages"),n.e(11).then(function(t){return function(){var e,o,r;return e=n("b5Zz"),r=new e({collection:t.collection}),o=t.collection.fetch(),o.done(function(){return t.layout.showChildView("content",r)}),o.fail(function(){return u.request("danger","Failed to load documents.")})}}(this).bind(null,n)).catch(n.oe)},e.prototype.edit_page=function(t){return this.setup_layout_if_needed(),n.e(10).then(function(e){return function(){var o,r;return o=n("qdJU").EditPageView,r=i.request("get-document",t),e._load_view(o,r)}}(this).bind(null,n)).catch(n.oe)},e.prototype.view_page=function(t){return this.setup_layout_if_needed(),n.e(11).then(function(e){return function(){var o,r;return o=n("6tEF"),r=i.request("get-document",t),e._load_view(o,r)}}(this).bind(null,n)).catch(n.oe)},e.prototype.new_page=function(){return this.setup_layout_if_needed(),n.e(10).then(function(t){return function(){var e,o;return e=n("qdJU").NewPageView,o=new e,t.layout.showChildView("content",o)}}(this).bind(null,n)).catch(n.oe)},e}(r),t.exports=o},EarI:function(t,e){function n(t){if(t=String(t),!(t.length>1e4)){var e=/^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i.exec(t);if(e){var n=parseFloat(e[1]);switch((e[2]||"ms").toLowerCase()){case"years":case"year":case"yrs":case"yr":case"y":return n*a;case"days":case"day":case"d":return n*p;case"hours":case"hour":case"hrs":case"hr":case"h":return n*s;case"minutes":case"minute":case"mins":case"min":case"m":return n*c;case"seconds":case"second":case"secs":case"sec":case"s":return n*i;case"milliseconds":case"millisecond":case"msecs":case"msec":case"ms":return n;default:return}}}}function o(t){return t>=p?Math.round(t/p)+"d":t>=s?Math.round(t/s)+"h":t>=c?Math.round(t/c)+"m":t>=i?Math.round(t/i)+"s":t+"ms"}function r(t){return u(t,p,"day")||u(t,s,"hour")||u(t,c,"minute")||u(t,i,"second")||t+" ms"}function u(t,e,n){if(!(t<e))return t<1.5*e?Math.floor(t/e)+" "+n:Math.ceil(t/e)+" "+n+"s"}var i=1e3,c=60*i,s=60*c,p=24*s,a=365.25*p;t.exports=function(t,e){e=e||{};var u=typeof t;if("string"===u&&t.length>0)return n(t);if("number"===u&&!1===isNaN(t))return e.long?r(t):o(t);throw new Error("val is not a non-empty string or a valid number. val="+JSON.stringify(t))}},GXmR:function(t,e,n){var o,r,u,i,c,s,p,a,l=function(t,e){function n(){this.constructor=t}for(var o in e)f.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},f={}.hasOwnProperty;n("4kSj"),o=n("aGLy"),n("y11e"),u=n("iuxk").DefaultAppletLayout,s=n("NOnk").navbar_set_active,p=n("SiCa"),a=n("9w6x"),i=o.Radio.channel("global"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.init_page=function(){},e.prototype.scroll_top=a,e.prototype.navigate_to_url=p,e.prototype.navbar_set_active=s,e}(o.Marionette.Object),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.layoutClass=u,e.prototype._get_applet=function(){var t;return t=i.request("main:app:object"),t.getView().getRegion("applet")},e.prototype.setup_layout=function(){var t;return this.layout=new this.layoutClass,t=this._get_applet(),t.hasView()&&t.empty(),t.show(this.layout)},e.prototype.setup_layout_if_needed=function(){return void 0===this.layout?this.setup_layout():this.layout.isDestroyed()?this.setup_layout():void 0},e.prototype._get_region=function(t){return this.layout.getRegion(t)},e.prototype._show_content=function(t){var e;return console.warn("_show_content is deprecated"),e=this._get_region("content"),e.show(t)},e.prototype._empty_sidebar=function(){var t;return t=this._get_region("sidebar"),t.empty(),t},e.prototype._make_sidebar=function(){var t,e;return console.warn("_make_sidebar is deprecated"),t=this._empty_sidebar(),e=new this.sidebarclass({model:this.sidebar_model}),t.show(e)},e.prototype._show_view=function(t,e){var n;return n=new t({model:e}),this.layout.showChildView("content",n)},e.prototype._load_view=function(t,e,n){var o;return e.isEmpty()||1===Object.keys(e.attributes).length?(o=e.fetch(),o.done(function(n){return function(){return n._show_view(t,e)}}(this)),o.fail(function(t){return function(){var t;return t="Failed to load "+n+" data.",MessageChannel.request("danger",t)}}())):this._show_view(t,e)},e}(r),t.exports={BaseController:r,MainController:c}},"Ju+O":function(t,e,n){var o,r,u,i,c,s,p,a,l,f,y,d=function(t,e){function n(){this.constructor=t}for(var o in e)h.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},h={}.hasOwnProperty;r=n("aGLy"),n("nSjZ").make_dbchannel,o=r.Radio.channel("ebcsv"),c={platinum:{start:1897,end:1937},golden:{start:1938,end:1955},silver:{start:1956,end:1969},bronze:{start:1970,end:1983},copper:{start:1984,end:1991},modern:{start:1992,end:2100}},y=function(t){var e,n;for(n in c)if(e=c[n],t>=e.start&&t<=e.end)return n;return!1},o.reply("get-comic-ages",function(){return c}),o.reply("get-age",function(t){return y(t)}),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return d(e,t),e.prototype.initialize=function(){return this.fetch(),this.on("change",this.save,this)},e.prototype.fetch=function(){return this.set(JSON.parse(localStorage.getItem(this.id)))},e.prototype.save=function(t,e){return localStorage.setItem(this.id,JSON.stringify(this.toJSON())),$.ajax({success:e.success,error:e.error})},e.prototype.destroy=function(t){return localStorage.removeItem(this.id)},e.prototype.isEmpty=function(){return _.size(this.attributes<=1)},e}(r.Model),a=["format","location","returnsacceptedoption","duration","quantity","startprice","dispatchtimemax","conditionid"],o.reply("csv-req-fieldnames",function(){return a}),p=["postalcode","paymentprofilename","returnprofilename","shippingprofilename","scheduletime"],o.reply("csv-opt-fieldnames",function(){return p}),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return d(e,t),e}(i),function(t){function e(){return e.__super__.constructor.apply(this,arguments)}d(e,t),e.prototype.fieldType="required",e.prototype.fieldNames=a}(u),function(t){function e(){return e.__super__.constructor.apply(this,arguments)}d(e,t),e.prototype.fieldType="optional",e.prototype.fieldNames=p}(u),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return d(e,t),e.prototype.id="ebcsv_settings",e}(i),l="4mhV8B1YQK6PUA2NW8eZZXVHjU55TPJ3UZnZGrbSoCnqJaxDyH",f=new s({consumer_key:l}),o.reply("get_ebcsv_settings",function(){return f}),t.exports={}},NOnk:function(t,e,n){var o,r,u,i;o=n("4kSj"),n("aGLy"),r=function(t,e,n){var o;return o=new n,t.reply("main-controller",function(){return o}),new e({controller:o})},u=function(t,e){return t.reply("get-navbar-color",function(){var t;return t=o(e),t.css("color")}),t.reply("get-navbar-bg-color",function(){var t;return t=o(e),t.css("background-color")})},i=function(t){var e,n,r,u,i,c,s;for(i=t.split("/")[0],c=o("#navbar-view li"),s=[],e=0,n=c.length;e<n;e++)r=c[e],u=o(r),u.removeClass("active"),i===u.attr("appname")?s.push(u.addClass("active")):s.push(void 0);return s},t.exports={create_new_approuter:r,navbar_color_handlers:u,navbar_set_active:i}},R0Nh:function(t,e,n){var o,r,u,i,c,s,p=function(t,e){function n(){this.constructor=t}for(var o in e)a.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},a={}.hasOwnProperty;i=n("y11e"),s=n("agle"),n("zap6"),r=n("EWhg"),u=Backbone.Radio.channel("global"),Backbone.Radio.channel("resources"),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.appRoutes={dbdocs:"list_pages","dbdocs/documents":"list_pages","dbdocs/documents/new":"new_page","dbdocs/documents/view/:id":"view_page","dbdocs/documents/edit/:id":"edit_page"},e}(i.AppRouter),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.Controller=r,e.prototype.Router=c,e.prototype.onBeforeStart=function(){return e.__super__.onBeforeStart.call(this,arguments),u.reply("applet:dbdocs:router",function(t){return function(){return t.router}}(this)),u.reply("applet:dbdocs:controller",function(t){return function(){return t.router.controller}}(this))},e}(s),u.reply("applet:dbdocs:route",function(){var t,e;return console.warn("Don't use applet:dbdocs:route"),t=new r(u),e=new c({controller:t}),u.reply("applet:dbdocs:router",function(){return e}),u.reply("applet:dbdocs:controller",function(){return t})}),t.exports=o},SiCa:function(t,e,n){var o;o=n("aGLy"),t.exports=function(t){var e;return""===t.split("/")[0]?window.location=t:(e=new o.Router,e.navigate(t,{trigger:!0}))}},Zu8L:function(t,e,n){var o,r,u,i=function(t,e){function n(){this.constructor=t}for(var o in e)c.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},c={}.hasOwnProperty;o=n("aGLy"),n("y11e"),o.Radio.channel("global"),r=n("l9Gg"),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.onDomRefresh=function(){var t;return t=new r,this.view.showChildView("content",t)},e}(o.Marionette.Behavior),t.exports=u},agle:function(t,e,n){var o,r,u=function(t,e){function n(){this.constructor=t}for(var o in e)i.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},i={}.hasOwnProperty;n("y11e"),r=n("HWfR"),Backbone.Radio.channel("global"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.onBeforeStart=function(){var t,e;if(e=new this.Controller,e.applet=this,this.router=new this.Router({controller:e}),null!=this?this.appRoutes:void 0)return t=("function"==typeof this.appRoutes?this.appRoutes():void 0)||this.appRoutes,Object.keys(t).forEach(function(e){return function(n){return e.router.appRoute(n,t[n])}}(this))},e.prototype.onStop=function(){return console.log("Stopping TkApplet",this.isRunning())},e}(r.App),t.exports=o},iuxk:function(t,e,n){var o,r,u,i,c,s,p,a,l=function(t,e){function n(){this.constructor=t}for(var o in e)f.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},f={}.hasOwnProperty;o=n("aGLy"),n("y11e"),a=n("2mEY"),p=n("EarI"),r=n("Zu8L"),i=n("yk0R"),s=function(t,e,n){return null==t&&(t=3),null==e&&(e="sm"),null==n&&(n="left"),a.renderable(function(){if("left"===n&&a.div("#sidebar.col-"+e+"-"+t+".left-column"),a.div("#main-content.col-"+e+"-"+(12-t)),"right"===n)return a.div("#sidebar.col-"+e+"-"+t+".right-column")})},u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.template=s(),e.prototype.regions={sidebar:"#sidebar",content:"#main-content"},e}(o.Marionette.View),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.behaviors={ShowInitialEmptyContent:{behaviorClass:r}},e.prototype.template=a.renderable(function(){return a.div(".col-sm-12",function(){return a.div(".row",function(){return a.div("#main-toolbar.col-sm-8.col-sm-offset-2")}),a.div(".row",function(){return a.div("#main-content.col-sm-10.col-sm-offset-1")})})}),e.prototype.regions=function(){var t;return t=new i({el:"#main-content"}),t.slide_speed=p(".01s"),{content:t,toolbar:"#main-toolbar"}},e}(o.Marionette.View),t.exports={SidebarAppletLayout:u,ToolbarAppletLayout:c}},l9Gg:function(t,e,n){var o,r,u,i=function(t,e){function n(){this.constructor=t}for(var o in e)c.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},c={}.hasOwnProperty;o=n("aGLy"),n("y11e"),u=n("2mEY"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.template=u.renderable(function(){return u.div(".jumbotron",function(){return u.h1(function(){return u.text("Loading ..."),u.i(".fa.fa-spinner.fa-spin")})})}),e}(o.Marionette.View),t.exports=r},nSjZ:function(t,e,n){var o,r,u,i,c,s=function(t,e){function n(){this.constructor=t}for(var o in e)p.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},p={}.hasOwnProperty;o=n("aGLy"),n("y11e"),r=function(t,e){var n,o,r;o=t.create();for(n in e)r=e[n],o.set(n,r);return t.add(o),t.save()},u=function(t,e){var n;return n=t.get(e),void 0===n?new t.model({id:e}):n},c=function(t,e){var n,r;return r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.urlRoot=e,n}(o.Model),n=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.model=r,n.prototype.url=e,n}(o.Model),{modelClass:r,collectionClass:n}},i=function(t,e,n,o){var i;return i=new o,t.reply(e+"-collection",function(){return i}),t.reply("new-"+e,function(){return new n}),t.reply("add-"+e,function(t){return r(i(t))}),t.reply("get-"+e,function(t){return u(i,t)}),t.reply(e+"-modelClass",function(){return n}),t.reply(e+"-collectionClass",function(){return o})},t.exports={make_dbclasses:c,make_dbchannel:i}},qAUr:function(t,e,n){var o,r,u,i,c,s,p=function(t,e){function n(){this.constructor=t}for(var o in e)a.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},a={}.hasOwnProperty;i=n("y11e"),s=n("agle"),n("Ju+O"),r=n("vK6X"),u=Backbone.Radio.channel("global"),Backbone.Radio.channel("resources"),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.appRoutes={ebcsv:"config_view"},e}(i.AppRouter),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.Controller=r,e.prototype.Router=c,e.prototype.onBeforeStart=function(){return e.__super__.onBeforeStart.call(this,arguments),u.reply("applet:ebcsv:router",function(t){return function(){return t.router}}(this)),u.reply("applet:ebcsv:controller",function(t){return function(){return t.router.controller}}(this))},e}(s),u.reply("applet:ebcsv:route",function(){var t,e;return console.warn("Don't use applet:ebcsv:route"),t=new r(u),e=new c({controller:t}),u.reply("applet:ebcsv:router",function(){return e}),u.reply("applet:ebcsv:controller",function(){return t})}),t.exports=o},vK6X:function(t,e,n){var o,r,u,i,c,s,p=function(t,e){function n(){this.constructor=t}for(var o in e)a.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},a={}.hasOwnProperty;u=n("GXmR").MainController,Backbone.Radio.channel("global"),i=Backbone.Radio.channel("messages"),c=Backbone.Radio.channel("resources"),o=Backbone.Radio.channel("ebcsv"),s=n("iuxk").ToolbarAppletLayout,r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.layoutClass=s,e.prototype.setup_layout_if_needed=function(){return e.__super__.setup_layout_if_needed.call(this)},e.prototype.collection=c.request("document-collection"),e.prototype.config_view=function(){return this.setup_layout_if_needed(),n.e(0).then(function(t){return function(){var e,r,u;return e=n("kc5A"),r=o.request("get_ebcsv_settings"),u=new e({model:r}),t.layout.showChildView("content",u)}}(this).bind(null,n)).catch(n.oe)},e.prototype.list_pages=function(){return this.setup_layout_if_needed(),console.log("List Pages"),n.e(11).then(function(t){return function(){var e,o,r;return e=n("lww4"),r=new e({collection:t.collection}),o=t.collection.fetch(),o.done(function(){return t.layout.showChildView("content",r)}),o.fail(function(){return i.request("danger","Failed to load documents.")})}}(this).bind(null,n)).catch(n.oe)},e.prototype.edit_page=function(t){return this.setup_layout_if_needed(),n.e(10).then(function(e){return function(){var o,r;return o=n("uYZh").EditPageView,r=c.request("get-document",t),e._load_view(o,r)}}(this).bind(null,n)).catch(n.oe)},e.prototype.view_page=function(t){return this.setup_layout_if_needed(),n.e(11).then(function(e){return function(){var o,r;return o=n("U5CE"),r=c.request("get-document",t),e._load_view(o,r)}}(this).bind(null,n)).catch(n.oe)},e.prototype.new_page=function(){return this.setup_layout_if_needed(),n.e(10).then(function(t){return function(){var e,o;return e=n("uYZh").NewPageView,o=new e,t.layout.showChildView("content",o)}}(this).bind(null,n)).catch(n.oe)},e}(u),t.exports=r},yk0R:function(t,e,n){var o,r,u=function(t,e){function n(){this.constructor=t}for(var o in e)i.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},i={}.hasOwnProperty;n("4kSj"),o=n("y11e"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.attachHtml=function(t){var e;return e=this.slide_speed?this.slide_speed:"fast",this.$el.hide(),this.$el.html(t.el),this.$el.slideDown(e)},e}(o.Region),t.exports=r},zap6:function(t,e,n){var o,r,u,i,c,s,p=function(t,e){function n(){this.constructor=t}for(var o in e)a.call(e,o)&&(t[o]=e[o]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},a={}.hasOwnProperty;o=n("aGLy"),s=n("nSjZ").make_dbchannel,i=o.Radio.channel("resources"),c="/api/dev/booky/DbDoc",r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.urlRoot=c,e}(o.Model),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.url=c,e.prototype.model=r,e}(o.Collection),s(i,"document",r,u),t.exports={DocumentCollection:u}}});