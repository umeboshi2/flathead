webpackJsonp([7],{"1QDq":function(t,e,o){var n,r,i,u=function(t,e){function o(){this.constructor=t}for(var n in e)s.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},s={}.hasOwnProperty;r=o("GXmR").MainController,Backbone.Radio.channel("global"),Backbone.Radio.channel("messages"),Backbone.Radio.channel("dbadmin"),Backbone.Radio.channel("resources"),i=o("iuxk").ToolbarAppletLayout,n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.layoutClass=i,e.prototype.setup_layout_if_needed=function(){return e.__super__.setup_layout_if_needed.call(this)},e.prototype.mainview=function(){return this.setup_layout_if_needed(),console.log("List Pages"),o.e(24).then(function(t){return function(){var e,n;return e=o("etUh"),n=new e,t.layout.showChildView("content",n)}}(this).bind(null,o)).catch(o.oe)},e}(r),t.exports=n},"3obO":function(t,e,o){var n,r,i,u,s,p,a,c,l,y,f,h,_,d,m,g,v,w,b,C,R,x,O=function(t,e){function o(){this.constructor=t}for(var n in e)M.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},M={}.hasOwnProperty;g=o("rdLu"),i=o("aGLy"),o("y11e"),p=o("lFa5"),_=i.Radio.channel("global"),i.Radio.channel("dbadmin"),r=_.request("main:app:AuthModel"),n=_.request("main:app:AuthCollection"),v="/api/dev/bapi",w=v+"/ebcsvcfg",R=v+"/ebcsvdsc",b={channelName:"dbadmin"},y=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.urlRoot=w,e.prototype.parse=function(t,o){return"string"==typeof t.content&&(t.content=JSON.parse(t.content)),e.__super__.parse.call(this,t,o)},e}(r),l=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.url=w,e.prototype.model=y,e}(n),new p(g.extend(b,{modelName:"ebcfg",modelClass:y,collectionClass:l})),h=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.urlRoot=R,e}(r),f=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.url=R,e.prototype.model=h,e}(n),new p(g.extend(b,{modelName:"ebdsc",modelClass:h,collectionClass:f})),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.urlRoot=v+"/ebclzpage",e.prototype.parse=function(t,o){return"string"==typeof t.clzdata&&(t.clzdata=JSON.parse(t.clzdata)),e.__super__.parse.call(this,t,o)},e}(r),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.url=v+"/ebclzpage",e.prototype.model=u,e}(n),new p(g.extend(b,{modelName:"clzpage",modelClass:u,collectionClass:s})),C="/api/dev/booky/DbDoc",a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.urlRoot=C,e}(r),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.url=C,e.prototype.model=a,e}(n),new p(g.extend(b,{modelName:"document",modelClass:a,collectionClass:c})),x="/api/dev/bapi/fhtodos",d=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.urlRoot=x,e.prototype.defaults={completed:!1},e}(r),m=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return O(e,t),e.prototype.url=x,e.prototype.model=d,e}(n),new p(g.extend(b,{modelName:"todo",modelClass:d,collectionClass:m})),t.exports={DocumentCollection:c}},"9w6x":function(t,e){t.exports=function(){return window.scrollTo(0,0)}},EarI:function(t,e){function o(t){if(t=String(t),!(t.length>100)){var e=/^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i.exec(t);if(e){var o=parseFloat(e[1]);switch((e[2]||"ms").toLowerCase()){case"years":case"year":case"yrs":case"yr":case"y":return o*c;case"days":case"day":case"d":return o*a;case"hours":case"hour":case"hrs":case"hr":case"h":return o*p;case"minutes":case"minute":case"mins":case"min":case"m":return o*s;case"seconds":case"second":case"secs":case"sec":case"s":return o*u;case"milliseconds":case"millisecond":case"msecs":case"msec":case"ms":return o;default:return}}}}function n(t){return t>=a?Math.round(t/a)+"d":t>=p?Math.round(t/p)+"h":t>=s?Math.round(t/s)+"m":t>=u?Math.round(t/u)+"s":t+"ms"}function r(t){return i(t,a,"day")||i(t,p,"hour")||i(t,s,"minute")||i(t,u,"second")||t+" ms"}function i(t,e,o){if(!(t<e))return t<1.5*e?Math.floor(t/e)+" "+o:Math.ceil(t/e)+" "+o+"s"}var u=1e3,s=60*u,p=60*s,a=24*p,c=365.25*a;t.exports=function(t,e){e=e||{};var i=typeof t;if("string"===i&&t.length>0)return o(t);if("number"===i&&!1===isNaN(t))return e.long?r(t):n(t);throw new Error("val is not a non-empty string or a valid number. val="+JSON.stringify(t))}},GXmR:function(t,e,o){var n,r,i,u,s,p,a,c,l,y=function(t,e){function o(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},f={}.hasOwnProperty;o("4kSj"),n=o("aGLy"),a=o("y11e"),i=o("iuxk").DefaultAppletLayout,c=o("SiCa"),l=o("9w6x"),s=n.Radio.channel("global"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.init_page=function(){},e.prototype.scroll_top=l,e.prototype.navigate_to_url=c,e}(a.Object),p=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.layoutClass=i,e.prototype._get_applet=function(){var t;return t=s.request("main:app:object"),t.getView().getRegion("applet")},e.prototype.setup_layout=function(){var t;return this.layout=new this.layoutClass,t=this._get_applet(),t.hasView()&&t.empty(),t.show(this.layout)},e.prototype.setup_layout_if_needed=function(){return void 0===this.layout?this.setup_layout():this.layout.isDestroyed()?this.setup_layout():void 0},e.prototype._get_region=function(t){return this.layout.getRegion(t)},e.prototype._show_view=function(t,e){var o;return o=new t({model:e}),this.layout.showChildView("content",o)},e.prototype._load_view=function(t,e,o){var n;return e.isEmpty()||1===Object.keys(e.attributes).length?(n=e.fetch(),n.done(function(o){return function(){return o._show_view(t,e)}}(this)),n.fail(function(){var t;return t="Failed to load "+o+" data.",MessageChannel.request("danger",t)})):this._show_view(t,e)},e}(r),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.channelName=function(){return this.getOption("channelName")||"global"},e.prototype.initialize=function(t){return this.appletName=t.appletName,this.applet=s.request("main:applet:get-applet",this.appletName),this.mainController=this.applet.router.controller,this.channel=this.getChannel()},e.prototype.setup_layout_if_needed=function(){return this.mainController.setup_layout_if_needed()},e.prototype.showChildView=function(t,e){return this.mainController.layout.showChildView(t,e)},e}(r),t.exports={BaseController:r,MainController:p,ExtraController:u}},PWmu:function(t,e,o){var n,r,i,u,s,p=function(t,e){function o(){this.constructor=t}for(var n in e)a.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},a={}.hasOwnProperty;i=o("y11e"),s=o("agle"),o("3obO"),r=o("1QDq"),Backbone.Radio.channel("global"),Backbone.Radio.channel("dbadmin"),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.appRoutes={dbadmin:"mainview"},e}(i.AppRouter),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.Controller=r,e.prototype.Router=u,e}(s),t.exports=n},SiCa:function(t,e,o){var n;n=o("aGLy"),t.exports=function(t){var e;return""===t.split("/")[0]?window.location=t:(e=new n.Router,e.navigate(t,{trigger:!0}))}},Zu8L:function(t,e,o){var n,r,i,u=function(t,e){function o(){this.constructor=t}for(var n in e)s.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},s={}.hasOwnProperty;n=o("aGLy"),o("y11e"),n.Radio.channel("global"),r=o("l9Gg"),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.onDomRefresh=function(){var t;return t=new r,this.view.showChildView("content",t)},e}(n.Marionette.Behavior),t.exports=i},agle:function(t,e,o){var n,r,i=function(t,e){function o(){this.constructor=t}for(var n in e)u.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},u={}.hasOwnProperty,s=[].indexOf||function(t){for(var e=0,o=this.length;e<o;e++)if(e in this&&this[e]===t)return e;return-1};o("y11e"),r=o("HWfR"),Backbone.Radio.channel("global"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.onBeforeStart=function(){var t,e,o,n,r;return e=new this.Controller,e.applet=this,this.router=new this.Router({controller:e}),(null!=this?this.appRoutes:void 0)&&(t=("function"==typeof this.appRoutes?this.appRoutes():void 0)||this.appRoutes,Object.keys(t).forEach(function(e){return function(o){return e.router.appRoute(o,t[o])}}(this))),(null!=(n=this.options)?n.isFrontdoorApplet:void 0)&&(o=(null!=(r=this.options.appConfig)?r.startFrontdoorMethod:void 0)||"start",s.call(Object.keys(this.router.appRoutes),"")<0&&this.router.appRoute("",o)),this._extraRouters={},this.initExtraRouters()},e.prototype.onStop=function(){},e.prototype.setExtraRouter=function(t,e,o){var n,r;return n=new o,r=new e({controller:n}),this._extraRouters[t]=r},e.prototype.initExtraRouters=function(){var t,e,o,n;t=this.getOption("extraRouters"),this.getOption("extraRouters"),e=[];for(n in t)o=t[n],console.log("rtr",n,o),this.setExtraRouter(n,o.router,o.controller),e.push(void 0);return e},e.prototype.getExtraRouter=function(t){return this._extraRouters[t]},e}(r.App),t.exports=n},iuxk:function(t,e,o){var n,r,i,u,s,p,a,c,l=function(t,e){function o(){this.constructor=t}for(var n in e)y.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},y={}.hasOwnProperty;n=o("aGLy"),o("y11e"),c=o("plj+"),a=o("EarI"),r=o("Zu8L"),u=o("yk0R"),p=function(t,e,o){return null==t&&(t=3),null==e&&(e="sm"),null==o&&(o="left"),c.renderable(function(){if("left"===o&&c.div("#sidebar.col-"+e+"-"+t+".left-column"),c.div("#main-content.col-"+e+"-"+(12-t)),"right"===o)return c.div("#sidebar.col-"+e+"-"+t+".right-column")})},i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.template=p(),e.prototype.regions={sidebar:"#sidebar",content:"#main-content"},e}(n.Marionette.View),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.behaviors={ShowInitialEmptyContent:{behaviorClass:r}},e.prototype.template=c.renderable(function(){return c.div(".col-sm-12",function(){return c.div(".row",function(){return c.div("#main-toolbar.col-sm-8.col-sm-offset-2")}),c.div(".row",function(){return c.div("#main-content.col-sm-10.col-sm-offset-1")})})}),e.prototype.regions=function(){var t;return t=new u({el:"#main-content"}),t.slide_speed=a(".01s"),{content:t,toolbar:"#main-toolbar"}},e}(n.Marionette.View),t.exports={SidebarAppletLayout:i,ToolbarAppletLayout:s}},l9Gg:function(t,e,o){var n,r,i,u=function(t,e){function o(){this.constructor=t}for(var n in e)s.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},s={}.hasOwnProperty;n=o("aGLy"),o("y11e"),i=o("plj+"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.template=i.renderable(function(){return i.div(".jumbotron",function(){return i.h1(function(){return i.text("Loading ..."),i.i(".fa.fa-spinner.fa-spin")})})}),e}(n.Marionette.View),t.exports=r},lFa5:function(t,e,o){var n,r,i,u=function(t,e){function o(){this.constructor=t}for(var n in e)s.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},s={}.hasOwnProperty;n=o("aGLy"),i=o("y11e"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.initialize=function(t){var e;return e=t.collectionClass||n.Collection,this.collection=new e,this.channelName=t.channelName||"global"},e.prototype.radioRequests=function(){var t,e,o;return e={},t=this.getOption("modelName"),t=t||"model",o="db:"+t,e[o+":collection"]="getCollection",e[o+":new"]="newModel",e[o+":add"]="addModel",e[o+":update"]="updateModel",e[o+":updatePassed"]="updatePassedModel",e[o+":get"]="getModel",e[o+":modelClass"]="getModelClass",e[o+":collectionClass"]="getCollectionClass",e},e.prototype.getCollection=function(){return this.collection},e.prototype.newModel=function(t){return t=t||{},new(this.getOption("modelClass"))(t)},e.prototype.addModel=function(t){var e,o,n;return t=t||{},e=this.getChannel(),n=this.getOption("modelName"),o=this.collection.create(t),o.once("sync",function(){return e.trigger("db:"+n+":inserted")}),this.collection.add(o)},e.prototype.updatePassedModel=function(t,e){var o,n;return o=this.getChannel(),n=this.getOption("modelName"),t.once("sync",function(){return o.trigger("db:"+n+":updated")}),t.set(e),t.save()},e.prototype.getModel=function(t){var e;return e=this.collection.get(t),void 0===e?new this.collection.model({id:t}):e},e.prototype.getModelClass=function(){return this.getOption("modelClass")},e.prototype.getCollectionClass=function(){return this.getOption("collectionClass")},e}(i.Object),t.exports=r},yk0R:function(t,e,o){var n,r,i=function(t,e){function o(){this.constructor=t}for(var n in e)u.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},u={}.hasOwnProperty;o("4kSj"),n=o("y11e"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.attachHtml=function(t){var e;return e=this.slide_speed?this.slide_speed:"fast",this.$el.hide(),this.$el.html(t.el),this.$el.slideDown(e)},e}(n.Region),t.exports=r}});