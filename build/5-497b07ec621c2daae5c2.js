webpackJsonp([5],{"7IBN":function(t,e,r){var n,o,u,i,a,s,p,c,l,f,h=function(t,e){function r(){this.constructor=t}for(var n in e)y.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},y={}.hasOwnProperty;l=r("2mEY"),p=r("SiCa"),i=r("GXmR").MainController,a=r("iuxk").ToolbarAppletLayout,u=Backbone.Radio.channel("global"),Backbone.Radio.channel("messages"),n=Backbone.Radio.channel("userprofile"),c=new Backbone.Model({entries:[{name:"Profile",url:"#profile"},{name:"Map",url:"#profile/mapview"},{name:"Settings",url:"#profile/editconfig"},{name:"Change Password",url:"#profile/chpassword"}]}),f=l.renderable(function(t){return l.div(".btn-group.btn-group-justified",function(){var e,r,n,o,u,i;for(u=t.entries,i=[],r=0,o=u.length;r<o;r++)e=u[r],n=(null!=e?e.icon:void 0)||"info",i.push(l.div(".toolbar-button.btn.btn-default",{"button-url":e.url},function(){return l.span(".fa.fa-"+n," "+e.name)}));return i})}),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.template=f,e.prototype.ui={toolbarButton:".toolbar-button"},e.prototype.events={"click @ui.toolbarButton":"toolbarButtonPressed"},e.prototype.toolbarButtonPressed=function(t){var e;return console.log("toolbarButtonPressed",t),e=t.currentTarget.getAttribute("button-url"),p(e)},e}(Backbone.Marionette.View),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.layoutClass=a,e.prototype.setup_layout_if_needed=function(){var t;return e.__super__.setup_layout_if_needed.call(this),t=new s({model:c}),this.layout.showChildView("toolbar",t)},e.prototype.show_profile=function(){return this.setup_layout_if_needed(),r.e(20).then(function(t){return function(){var e,n,o;return e=r("QeTo"),n=u.request("current-user"),o=new e({model:n}),t.layout.showChildView("content",o)}}(this).bind(null,r)).catch(r.oe)},e.prototype.view_map=function(){return this.setup_layout_if_needed(),r.e(18).then(function(t){return function(){var e,n,o;return e=r("vf65"),n=u.request("current-user"),o=new e({model:n}),t._show_content(o)}}(this).bind(null,r)).catch(r.oe)},e.prototype.edit_config=function(){return this.setup_layout_if_needed(),r.e(10).then(function(t){return function(){var e,n,o;return e=r("qqlL"),n=u.request("current-user"),o=new e({model:n}),t.layout.showChildView("content",o)}}(this).bind(null,r)).catch(r.oe)},e.prototype.change_password=function(){return this.setup_layout_if_needed(),r.e(10).then(function(t){return function(){var e,o;return e=r("xSzf"),o=new e({model:n.request("new-password-model")}),t.layout.showChildView("content",o)}}(this).bind(null,r)).catch(r.oe)},e}(i),t.exports=o},"9w6x":function(t,e){t.exports=function(){return window.scrollTo(0,0)}},EarI:function(t,e){function r(t){if(t=String(t),!(t.length>100)){var e=/^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i.exec(t);if(e){var r=parseFloat(e[1]);switch((e[2]||"ms").toLowerCase()){case"years":case"year":case"yrs":case"yr":case"y":return r*c;case"days":case"day":case"d":return r*p;case"hours":case"hour":case"hrs":case"hr":case"h":return r*s;case"minutes":case"minute":case"mins":case"min":case"m":return r*a;case"seconds":case"second":case"secs":case"sec":case"s":return r*i;case"milliseconds":case"millisecond":case"msecs":case"msec":case"ms":return r;default:return}}}}function n(t){return t>=p?Math.round(t/p)+"d":t>=s?Math.round(t/s)+"h":t>=a?Math.round(t/a)+"m":t>=i?Math.round(t/i)+"s":t+"ms"}function o(t){return u(t,p,"day")||u(t,s,"hour")||u(t,a,"minute")||u(t,i,"second")||t+" ms"}function u(t,e,r){if(!(t<e))return t<1.5*e?Math.floor(t/e)+" "+r:Math.ceil(t/e)+" "+r+"s"}var i=1e3,a=60*i,s=60*a,p=24*s,c=365.25*p;t.exports=function(t,e){e=e||{};var u=typeof t;if("string"===u&&t.length>0)return r(t);if("number"===u&&!1===isNaN(t))return e.long?o(t):n(t);throw new Error("val is not a non-empty string or a valid number. val="+JSON.stringify(t))}},GXmR:function(t,e,r){var n,o,u,i,a,s,p,c,l=function(t,e){function r(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},f={}.hasOwnProperty;r("4kSj"),n=r("aGLy"),r("y11e"),u=r("iuxk").DefaultAppletLayout,s=r("NOnk").navbar_set_active,p=r("SiCa"),c=r("9w6x"),i=n.Radio.channel("global"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.init_page=function(){},e.prototype.scroll_top=c,e.prototype.navigate_to_url=p,e.prototype.navbar_set_active=s,e}(n.Marionette.Object),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.layoutClass=u,e.prototype._get_applet=function(){var t;return t=i.request("main:app:object"),t.getView().getRegion("applet")},e.prototype.setup_layout=function(){var t;return this.layout=new this.layoutClass,t=this._get_applet(),t.hasView()&&t.empty(),t.show(this.layout)},e.prototype.setup_layout_if_needed=function(){return void 0===this.layout?this.setup_layout():this.layout.isDestroyed()?this.setup_layout():void 0},e.prototype._get_region=function(t){return this.layout.getRegion(t)},e.prototype._show_content=function(t){var e;return console.warn("_show_content is deprecated"),e=this._get_region("content"),e.show(t)},e.prototype._empty_sidebar=function(){var t;return t=this._get_region("sidebar"),t.empty(),t},e.prototype._make_sidebar=function(){var t,e;return console.warn("_make_sidebar is deprecated"),t=this._empty_sidebar(),e=new this.sidebarclass({model:this.sidebar_model}),t.show(e)},e.prototype._show_view=function(t,e){var r;return r=new t({model:e}),this.layout.showChildView("content",r)},e.prototype._load_view=function(t,e,r){var n;return e.isEmpty()||1===Object.keys(e.attributes).length?(n=e.fetch(),n.done(function(r){return function(){return r._show_view(t,e)}}(this)),n.fail(function(t){return function(){var t;return t="Failed to load "+r+" data.",MessageChannel.request("danger",t)}}())):this._show_view(t,e)},e}(o),t.exports={BaseController:o,MainController:a}},NOnk:function(t,e,r){var n,o,u,i;n=r("4kSj"),r("aGLy"),o=function(t,e,r){var n;return n=new r,t.reply("main-controller",function(){return n}),new e({controller:n})},u=function(t,e){return t.reply("get-navbar-color",function(){var t;return t=n(e),t.css("color")}),t.reply("get-navbar-bg-color",function(){var t;return t=n(e),t.css("background-color")})},i=function(t){var e,r,o,u,i,a,s;for(i=t.split("/")[0],a=n("#navbar-view li"),s=[],e=0,r=a.length;e<r;e++)o=a[e],u=n(o),u.removeClass("active"),i===u.attr("appname")?s.push(u.addClass("active")):s.push(void 0);return s},t.exports={create_new_approuter:o,navbar_color_handlers:u,navbar_set_active:i}},SiCa:function(t,e,r){var n;n=r("aGLy"),t.exports=function(t){var e;return""===t.split("/")[0]?window.location=t:(e=new n.Router,e.navigate(t,{trigger:!0}))}},"URa/":function(t,e,r){var n,o,u,i,a,s,p=function(t,e){function r(){this.constructor=t}for(var n in e)c.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},c={}.hasOwnProperty;n=r("aGLy"),u=n.Radio.channel("global"),i=n.Radio.channel("messages"),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e}(n.Model),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e}(a),s=function(t){var e;return e=new o,e.url=t,e},u.reply("create-current-user-object",function(t){var e;return e=s(t),u.reply("current-user",function(){return e}),u.reply("update-user-config",function(t){var r;return e.set("config",t),r=e.save(),r.done(function(){return e}),r.fail(function(){return i.request("danger","failed to update user config!")})}),e}),t.exports={User:a,CurrentUser:o}},"Uy6/":function(t,e,r){var n,o,u,i,a,s,p,c=function(t,e){function r(){this.constructor=t}for(var n in e)l.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},l={}.hasOwnProperty;a=r("y11e"),p=r("agle"),r("X7AR"),u=r("7IBN"),i=Backbone.Radio.channel("global"),n=Backbone.Radio.channel("userprofile"),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.appRoutes={profile:"show_profile","profile/editconfig":"edit_config","profile/chpassword":"change_password","profile/mapview":"view_map"},e}(a.AppRouter),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.Controller=u,e.prototype.Router=s,e.prototype.onBeforeStart=function(){return e.__super__.onBeforeStart.call(this,arguments),i.reply("applet:annex:router",function(t){return function(){return t.router}}(this)),i.reply("applet:annex:controller",function(t){return function(){return t.router.controller}}(this)),n.reply("main-controller",function(t){return function(){return console.warn("Stop using 'main-controller' request on AppChannel"),t.router.controller}}(this))},e}(p),i.reply("applet:userprofile:route",function(){var t;return t=new u(i),new s({controller:t})}),t.exports=o},X7AR:function(t,e,r){var n,o,u,i,a,s,p,c=function(t,e){function r(){this.constructor=t}for(var n in e)l.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},l={}.hasOwnProperty;n=r("4kSj"),r("rdLu"),i=r("aGLy"),r("y11e"),p=r("URa/"),p.User,p.CurrentUser,a=i.Radio.channel("global"),i.Radio.channel("messages"),o=i.Radio.channel("userprofile"),o.reply("update-user-config",function(){return console.log("update-user-config called")}),u=a.request("main:app:AuthModel"),a.request("main:app:AuthCollection"),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.url="/auth/chpass",e.prototype.validation={password:{required:!0,minLength:8},confirm:function(t){var e,r;return r=n('input[name="password"]'),e=r.val(),t===e&&n('input[type="submit"]').show(),t!==e}},e}(u),o.reply("new-password-model",function(){return new s}),t.exports={}},Zu8L:function(t,e,r){var n,o,u,i=function(t,e){function r(){this.constructor=t}for(var n in e)a.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},a={}.hasOwnProperty;n=r("aGLy"),r("y11e"),n.Radio.channel("global"),o=r("l9Gg"),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.onDomRefresh=function(){var t;return t=new o,this.view.showChildView("content",t)},e}(n.Marionette.Behavior),t.exports=u},agle:function(t,e,r){var n,o,u=function(t,e){function r(){this.constructor=t}for(var n in e)i.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},i={}.hasOwnProperty,a=[].indexOf||function(t){for(var e=0,r=this.length;e<r;e++)if(e in this&&this[e]===t)return e;return-1};r("y11e"),o=r("HWfR"),Backbone.Radio.channel("global"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.onBeforeStart=function(){var t,e,r,n,o;if(e=new this.Controller,e.applet=this,this.router=new this.Router({controller:e}),(null!=this?this.appRoutes:void 0)&&(t=("function"==typeof this.appRoutes?this.appRoutes():void 0)||this.appRoutes,Object.keys(t).forEach(function(e){return function(r){return e.router.appRoute(r,t[r])}}(this))),(null!=(n=this.options)?n.isFrontdoorApplet:void 0)&&(r=(null!=(o=this.options.appConfig)?o.startFrontdoorMethod:void 0)||"start",a.call(Object.keys(this.router.appRoutes),"")<0))return this.router.appRoute("",r)},e.prototype.onStop=function(){return console.log("Stopping TkApplet",this.isRunning())},e}(o.App),t.exports=n},iuxk:function(t,e,r){var n,o,u,i,a,s,p,c,l=function(t,e){function r(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},f={}.hasOwnProperty;n=r("aGLy"),r("y11e"),c=r("2mEY"),p=r("EarI"),o=r("Zu8L"),i=r("yk0R"),s=function(t,e,r){return null==t&&(t=3),null==e&&(e="sm"),null==r&&(r="left"),c.renderable(function(){if("left"===r&&c.div("#sidebar.col-"+e+"-"+t+".left-column"),c.div("#main-content.col-"+e+"-"+(12-t)),"right"===r)return c.div("#sidebar.col-"+e+"-"+t+".right-column")})},u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.template=s(),e.prototype.regions={sidebar:"#sidebar",content:"#main-content"},e}(n.Marionette.View),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.behaviors={ShowInitialEmptyContent:{behaviorClass:o}},e.prototype.template=c.renderable(function(){return c.div(".col-sm-12",function(){return c.div(".row",function(){return c.div("#main-toolbar.col-sm-8.col-sm-offset-2")}),c.div(".row",function(){return c.div("#main-content.col-sm-10.col-sm-offset-1")})})}),e.prototype.regions=function(){var t;return t=new i({el:"#main-content"}),t.slide_speed=p(".01s"),{content:t,toolbar:"#main-toolbar"}},e}(n.Marionette.View),t.exports={SidebarAppletLayout:u,ToolbarAppletLayout:a}},l9Gg:function(t,e,r){var n,o,u,i=function(t,e){function r(){this.constructor=t}for(var n in e)a.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},a={}.hasOwnProperty;n=r("aGLy"),r("y11e"),u=r("2mEY"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.template=u.renderable(function(){return u.div(".jumbotron",function(){return u.h1(function(){return u.text("Loading ..."),u.i(".fa.fa-spinner.fa-spin")})})}),e}(n.Marionette.View),t.exports=o},yk0R:function(t,e,r){var n,o,u=function(t,e){function r(){this.constructor=t}for(var n in e)i.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},i={}.hasOwnProperty;r("4kSj"),n=r("y11e"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.attachHtml=function(t){var e;return e=this.slide_speed?this.slide_speed:"fast",this.$el.hide(),this.$el.html(t.el),this.$el.slideDown(e)},e}(n.Region),t.exports=o}});