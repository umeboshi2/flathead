webpackJsonp([6],{"9w6x":function(t,e){t.exports=function(){return window.scrollTo(0,0)}},EWhg:function(t,e,o){var n,r,i,u,s,a=function(t,e){function o(){this.constructor=t}for(var n in e)c.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},c={}.hasOwnProperty;r=o("GXmR").MainController,Backbone.Radio.channel("global"),i=Backbone.Radio.channel("messages"),u=Backbone.Radio.channel("resources"),s=o("iuxk").ToolbarAppletLayout,n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return a(e,t),e.prototype.layoutClass=s,e.prototype.setup_layout_if_needed=function(){return e.__super__.setup_layout_if_needed.call(this)},e.prototype.collection=u.request("document-collection"),e.prototype.list_pages=function(){return this.setup_layout_if_needed(),console.log("List Pages"),o.e(14).then(function(t){return function(){var e,n,r;return e=o("b5Zz"),r=new e({collection:t.collection}),n=t.collection.fetch(),n.done(function(){return t.layout.showChildView("content",r)}),n.fail(function(){return i.request("danger","Failed to load documents.")})}}(this).bind(null,o)).catch(o.oe)},e.prototype.edit_page=function(t){return this.setup_layout_if_needed(),o.e(11).then(function(e){return function(){var n,r;return n=o("qdJU").EditPageView,r=u.request("get-document",t),e._load_view(n,r)}}(this).bind(null,o)).catch(o.oe)},e.prototype.view_page=function(t){return this.setup_layout_if_needed(),o.e(14).then(function(e){return function(){var n,r;return n=o("6tEF"),r=u.request("get-document",t),e._load_view(n,r)}}(this).bind(null,o)).catch(o.oe)},e.prototype.new_page=function(){return this.setup_layout_if_needed(),o.e(11).then(function(t){return function(){var e,n;return e=o("qdJU").NewPageView,n=new e,t.layout.showChildView("content",n)}}(this).bind(null,o)).catch(o.oe)},e}(r),t.exports=n},EarI:function(t,e){function o(t){if(t=String(t),!(t.length>100)){var e=/^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i.exec(t);if(e){var o=parseFloat(e[1]);switch((e[2]||"ms").toLowerCase()){case"years":case"year":case"yrs":case"yr":case"y":return o*p;case"days":case"day":case"d":return o*c;case"hours":case"hour":case"hrs":case"hr":case"h":return o*a;case"minutes":case"minute":case"mins":case"min":case"m":return o*s;case"seconds":case"second":case"secs":case"sec":case"s":return o*u;case"milliseconds":case"millisecond":case"msecs":case"msec":case"ms":return o;default:return}}}}function n(t){return t>=c?Math.round(t/c)+"d":t>=a?Math.round(t/a)+"h":t>=s?Math.round(t/s)+"m":t>=u?Math.round(t/u)+"s":t+"ms"}function r(t){return i(t,c,"day")||i(t,a,"hour")||i(t,s,"minute")||i(t,u,"second")||t+" ms"}function i(t,e,o){if(!(t<e))return t<1.5*e?Math.floor(t/e)+" "+o:Math.ceil(t/e)+" "+o+"s"}var u=1e3,s=60*u,a=60*s,c=24*a,p=365.25*c;t.exports=function(t,e){e=e||{};var i=typeof t;if("string"===i&&t.length>0)return o(t);if("number"===i&&!1===isNaN(t))return e.long?r(t):n(t);throw new Error("val is not a non-empty string or a valid number. val="+JSON.stringify(t))}},GXmR:function(t,e,o){var n,r,i,u,s,a,c,p,l=function(t,e){function o(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},f={}.hasOwnProperty;o("4kSj"),n=o("aGLy"),o("y11e"),i=o("iuxk").DefaultAppletLayout,a=o("NOnk").navbar_set_active,c=o("SiCa"),p=o("9w6x"),u=n.Radio.channel("global"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.init_page=function(){},e.prototype.scroll_top=p,e.prototype.navigate_to_url=c,e.prototype.navbar_set_active=a,e}(n.Marionette.Object),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.layoutClass=i,e.prototype._get_applet=function(){var t;return t=u.request("main:app:object"),t.getView().getRegion("applet")},e.prototype.setup_layout=function(){var t;return this.layout=new this.layoutClass,t=this._get_applet(),t.hasView()&&t.empty(),t.show(this.layout)},e.prototype.setup_layout_if_needed=function(){return void 0===this.layout?this.setup_layout():this.layout.isDestroyed()?this.setup_layout():void 0},e.prototype._get_region=function(t){return this.layout.getRegion(t)},e.prototype._show_content=function(t){var e;return console.warn("_show_content is deprecated"),e=this._get_region("content"),e.show(t)},e.prototype._empty_sidebar=function(){var t;return t=this._get_region("sidebar"),t.empty(),t},e.prototype._make_sidebar=function(){var t,e;return console.warn("_make_sidebar is deprecated"),t=this._empty_sidebar(),e=new this.sidebarclass({model:this.sidebar_model}),t.show(e)},e.prototype._show_view=function(t,e){var o;return o=new t({model:e}),this.layout.showChildView("content",o)},e.prototype._load_view=function(t,e,o){var n;return e.isEmpty()||1===Object.keys(e.attributes).length?(n=e.fetch(),n.done(function(o){return function(){return o._show_view(t,e)}}(this)),n.fail(function(t){return function(){var t;return t="Failed to load "+o+" data.",MessageChannel.request("danger",t)}}())):this._show_view(t,e)},e}(r),t.exports={BaseController:r,MainController:s}},NOnk:function(t,e,o){var n,r,i,u;n=o("4kSj"),o("aGLy"),r=function(t,e,o){var n;return n=new o,t.reply("main-controller",function(){return n}),new e({controller:n})},i=function(t,e){return t.reply("get-navbar-color",function(){var t;return t=n(e),t.css("color")}),t.reply("get-navbar-bg-color",function(){var t;return t=n(e),t.css("background-color")})},u=function(t){var e,o,r,i,u,s,a;for(u=t.split("/")[0],s=n("#navbar-view li"),a=[],e=0,o=s.length;e<o;e++)r=s[e],i=n(r),i.removeClass("active"),u===i.attr("appname")?a.push(i.addClass("active")):a.push(void 0);return a},t.exports={create_new_approuter:r,navbar_color_handlers:i,navbar_set_active:u}},R0Nh:function(t,e,o){var n,r,i,u,s,a,c=function(t,e){function o(){this.constructor=t}for(var n in e)p.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},p={}.hasOwnProperty;u=o("y11e"),a=o("agle"),o("zap6"),r=o("EWhg"),i=Backbone.Radio.channel("global"),Backbone.Radio.channel("resources"),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.appRoutes={dbdocs:"list_pages","dbdocs/documents":"list_pages","dbdocs/documents/new":"new_page","dbdocs/documents/view/:id":"view_page","dbdocs/documents/edit/:id":"edit_page"},e}(u.AppRouter),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.Controller=r,e.prototype.Router=s,e.prototype.onBeforeStart=function(){return e.__super__.onBeforeStart.call(this,arguments),i.reply("applet:dbdocs:router",function(t){return function(){return t.router}}(this)),i.reply("applet:dbdocs:controller",function(t){return function(){return t.router.controller}}(this))},e}(a),t.exports=n},SiCa:function(t,e,o){var n;n=o("aGLy"),t.exports=function(t){var e;return""===t.split("/")[0]?window.location=t:(e=new n.Router,e.navigate(t,{trigger:!0}))}},Zu8L:function(t,e,o){var n,r,i,u=function(t,e){function o(){this.constructor=t}for(var n in e)s.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},s={}.hasOwnProperty;n=o("aGLy"),o("y11e"),n.Radio.channel("global"),r=o("l9Gg"),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.onDomRefresh=function(){var t;return t=new r,this.view.showChildView("content",t)},e}(n.Marionette.Behavior),t.exports=i},agle:function(t,e,o){var n,r,i=function(t,e){function o(){this.constructor=t}for(var n in e)u.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},u={}.hasOwnProperty,s=[].indexOf||function(t){for(var e=0,o=this.length;e<o;e++)if(e in this&&this[e]===t)return e;return-1};o("y11e"),r=o("HWfR"),Backbone.Radio.channel("global"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.onBeforeStart=function(){var t,e,o,n,r;if(e=new this.Controller,e.applet=this,this.router=new this.Router({controller:e}),(null!=this?this.appRoutes:void 0)&&(t=("function"==typeof this.appRoutes?this.appRoutes():void 0)||this.appRoutes,Object.keys(t).forEach(function(e){return function(o){return e.router.appRoute(o,t[o])}}(this))),(null!=(n=this.options)?n.isFrontdoorApplet:void 0)&&(o=(null!=(r=this.options.appConfig)?r.startFrontdoorMethod:void 0)||"start",s.call(Object.keys(this.router.appRoutes),"")<0))return this.router.appRoute("",o)},e.prototype.onStop=function(){return console.log("Stopping TkApplet",this.isRunning())},e}(r.App),t.exports=n},iuxk:function(t,e,o){var n,r,i,u,s,a,c,p,l=function(t,e){function o(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},f={}.hasOwnProperty;n=o("aGLy"),o("y11e"),p=o("2mEY"),c=o("EarI"),r=o("Zu8L"),u=o("yk0R"),a=function(t,e,o){return null==t&&(t=3),null==e&&(e="sm"),null==o&&(o="left"),p.renderable(function(){if("left"===o&&p.div("#sidebar.col-"+e+"-"+t+".left-column"),p.div("#main-content.col-"+e+"-"+(12-t)),"right"===o)return p.div("#sidebar.col-"+e+"-"+t+".right-column")})},i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.template=a(),e.prototype.regions={sidebar:"#sidebar",content:"#main-content"},e}(n.Marionette.View),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.behaviors={ShowInitialEmptyContent:{behaviorClass:r}},e.prototype.template=p.renderable(function(){return p.div(".col-sm-12",function(){return p.div(".row",function(){return p.div("#main-toolbar.col-sm-8.col-sm-offset-2")}),p.div(".row",function(){return p.div("#main-content.col-sm-10.col-sm-offset-1")})})}),e.prototype.regions=function(){var t;return t=new u({el:"#main-content"}),t.slide_speed=c(".01s"),{content:t,toolbar:"#main-toolbar"}},e}(n.Marionette.View),t.exports={SidebarAppletLayout:i,ToolbarAppletLayout:s}},l9Gg:function(t,e,o){var n,r,i,u=function(t,e){function o(){this.constructor=t}for(var n in e)s.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},s={}.hasOwnProperty;n=o("aGLy"),o("y11e"),i=o("2mEY"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.template=i.renderable(function(){return i.div(".jumbotron",function(){return i.h1(function(){return i.text("Loading ..."),i.i(".fa.fa-spinner.fa-spin")})})}),e}(n.Marionette.View),t.exports=r},nSjZ:function(t,e,o){var n,r,i,u,s,a=function(t,e){function o(){this.constructor=t}for(var n in e)c.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},c={}.hasOwnProperty;n=o("aGLy"),o("y11e"),r=function(t,e){var o,n,r;n=t.create();for(o in e)r=e[o],n.set(o,r);return t.add(n),t.save()},i=function(t,e){var o;return o=t.get(e),void 0===o?new t.model({id:e}):o},s=function(t,e){var o,r;return r=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return a(o,t),o.prototype.urlRoot=e,o}(n.Model),o=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return a(o,t),o.prototype.model=r,o.prototype.url=e,o}(n.Model),{modelClass:r,collectionClass:o}},u=function(t,e,o,n){var u;return u=new n,t.reply(e+"-collection",function(){return u}),t.reply("new-"+e,function(){return new o}),t.reply("add-"+e,function(t){return r(u(t))}),t.reply("get-"+e,function(t){return i(u,t)}),t.reply(e+"-modelClass",function(){return o}),t.reply(e+"-collectionClass",function(){return n})},t.exports={make_dbclasses:s,make_dbchannel:u}},yk0R:function(t,e,o){var n,r,i=function(t,e){function o(){this.constructor=t}for(var n in e)u.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},u={}.hasOwnProperty;o("4kSj"),n=o("y11e"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.attachHtml=function(t){var e;return e=this.slide_speed?this.slide_speed:"fast",this.$el.hide(),this.$el.html(t.el),this.$el.slideDown(e)},e}(n.Region),t.exports=r},zap6:function(t,e,o){var n,r,i,u,s,a,c,p,l,f=function(t,e){function o(){this.constructor=t}for(var n in e)_.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},_={}.hasOwnProperty;i=o("aGLy"),l=o("nSjZ").make_dbchannel,a=i.Radio.channel("global"),c=i.Radio.channel("resources"),p="/api/dev/booky/DbDoc",r=a.request("main:app:AuthModel"),n=a.request("main:app:AuthCollection"),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.urlRoot=p,e}(r),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.url=p,e.prototype.model=u,e}(n),l(c,"document",u,s),t.exports={DocumentCollection:s}}});