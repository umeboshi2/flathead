webpackJsonp([1],{"02NS":function(t,e,r){var n,o,i,a,u,c,s,l,p,f=function(t,e){function r(){this.constructor=t}for(var n in e)y.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},y={}.hasOwnProperty;n=r("aGLy"),r("y11e"),p=r("2mEY"),r("EarI"),a=r("GXmR").MainController,c=r("iuxk").ToolbarAppletLayout,l=r("SiCa"),n.Radio.channel("global"),u=n.Radio.channel("messages"),i=n.Radio.channel("hubby"),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.template=p.renderable(function(){return p.div(".btn-group.btn-group-justified",function(){return p.div("#show-calendar-button.btn.btn-default",function(){return p.i(".fa.fa-calendar"," Calendar")}),p.div("#list-meetings-button.btn.btn-default",function(){return p.i(".fa.fa-list"," List Meetings")})}),p.div(".input-group",function(){return p.input(".form-control",{type:"text",placeholder:"search",name:"search"}),p.span(".input-group-btn",function(){return p.button("#search-button.btn.btn-default",function(){return p.i(".fa.fa-search","Search")})})})}),e.prototype.ui={search_bth:"#search-button",show_cal_btn:"#show-calendar-button",list_btn:"#list-meetings-button",search_entry:".form-control"},e.prototype.events={"click @ui.show_cal_btn":"show_calendar","click @ui.list_btn":"list_meetings","click @ui.search_bth":"search_hubby"},e.prototype.show_calendar=function(){var t,e;return e="#hubby",window.location.hash===e?(t=i.request("main-controller"),t.mainview()):l("#hubby")},e.prototype.list_meetings=function(){return l("#hubby/listmeetings")},e.prototype.search_hubby=function(){var t,e;return t=i.request("main-controller"),e={searchParams:{title:this.ui.search_entry.val()}},console.log("search for",e),t.view_items(e)},e}(n.Marionette.View),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.layoutClass=c,e.prototype.setup_layout_if_needed=function(){return e.__super__.setup_layout_if_needed.call(this),this.layout.showChildView("toolbar",new s)},e.prototype.show_calendar=function(t,e){return r.e(16).then(function(){var n,o,i;return n=r("CosT"),o={},"minicalendar"===e&&(o.minicalendar=!0,o.layout=t),i=new n(o),t.showChildView(e,i)}.bind(null,r)).catch(r.oe)},e.prototype.mainview=function(){return this.setup_layout_if_needed(),this.show_calendar(this.layout,"content")},e.prototype.list_meetings=function(){return this.setup_layout_if_needed(),r.e(18).then(function(t){return function(){var e,n,o;return r("X1eX").MainMeetingModel,n=i.request("meetinglist"),e=r("X6F+"),o=n.fetch(),o.done(function(){var r;return r=new e({collection:n}),t.layout.showChildView("content",r)}),o.fail(function(){return u.request("danger","Failed to load meeting list")})}}(this).bind(null,r)).catch(r.oe)},e.prototype.show_meeting=function(t,e,n){return r.e(13).then(function(){var o,i,a,c;return o=r("X1eX").MainMeetingModel,i=r("HiIQ"),a=new o({id:n}),c=a.fetch(),c.done(function(){var r;return r=new i({model:a}),t.showChildView(e,r)}),c.fail(function(){return u.request("danger","Failed to load meeting")})}.bind(null,r)).catch(r.oe)},e.prototype.view_meeting=function(t){return this.setup_layout_if_needed(),this.show_meeting(this.layout,"content",t)},e.prototype.view_items=function(t){return this.setup_layout_if_needed(),this.list_items(this.layout,"content",t)},e.prototype.list_items=function(t,e,n){return r.e(9).then(function(){var o,i,a,u;return o=r("X1eX").ItemCollection,i=r("1eOK"),a=new o([]),a.searchParams=n.searchParams,console.log("ItemCollection",a),u=a.fetch(),u.done(function(){var r;return r=new i({collection:a}),t.showChildView(e,r)})}.bind(null,r)).catch(r.oe)},e}(a),t.exports=o},"9w6x":function(t,e){t.exports=function(){return window.scrollTo(0,0)}},CwSZ:function(t,e,r){"use strict";var n=r("p8xL"),o=r("XgCd"),i={brackets:function(t){return t+"[]"},indices:function(t,e){return t+"["+e+"]"},repeat:function(t){return t}},a=Date.prototype.toISOString,u={delimiter:"&",encode:!0,encoder:n.encode,encodeValuesOnly:!1,serializeDate:function(t){return a.call(t)},skipNulls:!1,strictNullHandling:!1},c=function t(e,r,o,i,a,u,c,s,l,p,f,y){var d=e;if("function"==typeof c)d=c(r,d);else if(d instanceof Date)d=p(d);else if(null===d){if(i)return u&&!y?u(r):r;d=""}if("string"==typeof d||"number"==typeof d||"boolean"==typeof d||n.isBuffer(d)){if(u){return[f(y?r:u(r))+"="+f(u(d))]}return[f(r)+"="+f(String(d))]}var h=[];if(void 0===d)return h;var _;if(Array.isArray(c))_=c;else{var m=Object.keys(d);_=s?m.sort(s):m}for(var v=0;v<_.length;++v){var b=_[v];a&&null===d[b]||(h=Array.isArray(d)?h.concat(t(d[b],o(r,b),o,i,a,u,c,s,l,p,f,y)):h.concat(t(d[b],r+(l?"."+b:"["+b+"]"),o,i,a,u,c,s,l,p,f,y)))}return h};t.exports=function(t,e){var r=t,n=e||{};if(null!==n.encoder&&void 0!==n.encoder&&"function"!=typeof n.encoder)throw new TypeError("Encoder has to be a function.");var a=void 0===n.delimiter?u.delimiter:n.delimiter,s="boolean"==typeof n.strictNullHandling?n.strictNullHandling:u.strictNullHandling,l="boolean"==typeof n.skipNulls?n.skipNulls:u.skipNulls,p="boolean"==typeof n.encode?n.encode:u.encode,f="function"==typeof n.encoder?n.encoder:u.encoder,y="function"==typeof n.sort?n.sort:null,d=void 0!==n.allowDots&&n.allowDots,h="function"==typeof n.serializeDate?n.serializeDate:u.serializeDate,_="boolean"==typeof n.encodeValuesOnly?n.encodeValuesOnly:u.encodeValuesOnly;if(void 0===n.format)n.format=o.default;else if(!Object.prototype.hasOwnProperty.call(o.formatters,n.format))throw new TypeError("Unknown format option provided.");var m,v,b=o.formatters[n.format];"function"==typeof n.filter?(v=n.filter,r=v("",r)):Array.isArray(n.filter)&&(v=n.filter,m=v);var w=[];if("object"!=typeof r||null===r)return"";var g;g=n.arrayFormat in i?n.arrayFormat:"indices"in n?n.indices?"indices":"repeat":"indices";var O=i[g];m||(m=Object.keys(r)),y&&m.sort(y);for(var C=0;C<m.length;++C){var j=m[C];l&&null===r[j]||(w=w.concat(c(r[j],j,O,s,l,p?f:null,v,y,d,h,b,_)))}return w.join(a)}},DDCP:function(t,e,r){"use strict";var n=r("p8xL"),o=Object.prototype.hasOwnProperty,i={allowDots:!1,allowPrototypes:!1,arrayLimit:20,decoder:n.decode,delimiter:"&",depth:5,parameterLimit:1e3,plainObjects:!1,strictNullHandling:!1},a=function(t,e){for(var r={},n=t.split(e.delimiter,e.parameterLimit===1/0?void 0:e.parameterLimit),i=0;i<n.length;++i){var a,u,c=n[i],s=-1===c.indexOf("]=")?c.indexOf("="):c.indexOf("]=")+1;-1===s?(a=e.decoder(c),u=e.strictNullHandling?null:""):(a=e.decoder(c.slice(0,s)),u=e.decoder(c.slice(s+1))),o.call(r,a)?r[a]=[].concat(r[a]).concat(u):r[a]=u}return r},u=function(t,e,r){if(!t.length)return e;var n,o=t.shift();if("[]"===o)n=[],n=n.concat(u(t,e,r));else{n=r.plainObjects?Object.create(null):{};var i="["===o.charAt(0)&&"]"===o.charAt(o.length-1)?o.slice(1,-1):o,a=parseInt(i,10);!isNaN(a)&&o!==i&&String(a)===i&&a>=0&&r.parseArrays&&a<=r.arrayLimit?(n=[],n[a]=u(t,e,r)):n[i]=u(t,e,r)}return n},c=function(t,e,r){if(t){var n=r.allowDots?t.replace(/\.([^.[]+)/g,"[$1]"):t,i=/(\[[^[\]]*])/,a=/(\[[^[\]]*])/g,c=i.exec(n),s=c?n.slice(0,c.index):n,l=[];if(s){if(!r.plainObjects&&o.call(Object.prototype,s)&&!r.allowPrototypes)return;l.push(s)}for(var p=0;null!==(c=a.exec(n))&&p<r.depth;){if(p+=1,!r.plainObjects&&o.call(Object.prototype,c[1].slice(1,-1))&&!r.allowPrototypes)return;l.push(c[1])}return c&&l.push("["+n.slice(c.index)+"]"),u(l,e,r)}};t.exports=function(t,e){var r=e||{};if(null!==r.decoder&&void 0!==r.decoder&&"function"!=typeof r.decoder)throw new TypeError("Decoder has to be a function.");if(r.delimiter="string"==typeof r.delimiter||n.isRegExp(r.delimiter)?r.delimiter:i.delimiter,r.depth="number"==typeof r.depth?r.depth:i.depth,r.arrayLimit="number"==typeof r.arrayLimit?r.arrayLimit:i.arrayLimit,r.parseArrays=!1!==r.parseArrays,r.decoder="function"==typeof r.decoder?r.decoder:i.decoder,r.allowDots="boolean"==typeof r.allowDots?r.allowDots:i.allowDots,r.plainObjects="boolean"==typeof r.plainObjects?r.plainObjects:i.plainObjects,r.allowPrototypes="boolean"==typeof r.allowPrototypes?r.allowPrototypes:i.allowPrototypes,r.parameterLimit="number"==typeof r.parameterLimit?r.parameterLimit:i.parameterLimit,r.strictNullHandling="boolean"==typeof r.strictNullHandling?r.strictNullHandling:i.strictNullHandling,""===t||null===t||void 0===t)return r.plainObjects?Object.create(null):{};for(var o="string"==typeof t?a(t,r):t,u=r.plainObjects?Object.create(null):{},s=Object.keys(o),l=0;l<s.length;++l){var p=s[l],f=c(p,o[p],r);u=n.merge(u,f,r)}return n.compact(u)}},DxIB:function(t,e,r){var n,o,i,a,u,c,s,l,p=function(t,e){function r(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},f={}.hasOwnProperty;u=r("y11e"),s=r("agle"),o=r("02NS"),r("X1eX"),a=Backbone.Radio.channel("global"),i=Backbone.Radio.channel("hubby"),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.appRoutes={hubby:"mainview","hubby/listmeetings":"list_meetings","hubby/viewmeeting/:id":"view_meeting","hubby/search":"view_items"},e}(u.AppRouter),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.Controller=o,e.prototype.Router=c,e.prototype.onBeforeStart=function(t){var r;return e.__super__.onBeforeStart.call(this,t),r=this.router.controller,i.reply("main-controller",function(){return r}),i.reply("view-calendar",function(t,e){return r.show_calendar(t,e)}),i.reply("view-meeting-orig",function(t,e,n){return r.show_meeting(t,e,n)}),i.reply("view-meeting",function(t){return r.show_meeting(t.layout,t.region,t.id)}),i.reply("view-items",function(t,e,n){return r.list_items(t,e,n)})},e}(s),l=void 0,l=new Date("2016-10-15"),i.reply("maincalendar:set-date",function(){var t;return t=$("#maincalendar"),l=t.fullCalendar("getDate")}),i.reply("maincalendar:get-date",function(){return l}),a.reply("applet:hubby:route",function(){var t;return console.warn("Don't use applet:hubby:route"),t=new o(a),i.reply("main-controller",function(){return t}),i.reply("view-calendar",function(e,r){return t.show_calendar(e,r)}),i.reply("view-meeting",function(e,r,n){return t.show_meeting(e,r,n)}),i.reply("view-items",function(e,r,n){return t.list_items(e,r,n)}),new c({controller:t})}),t.exports=n},EarI:function(t,e){function r(t){if(t=String(t),!(t.length>1e4)){var e=/^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i.exec(t);if(e){var r=parseFloat(e[1]);switch((e[2]||"ms").toLowerCase()){case"years":case"year":case"yrs":case"yr":case"y":return r*l;case"days":case"day":case"d":return r*s;case"hours":case"hour":case"hrs":case"hr":case"h":return r*c;case"minutes":case"minute":case"mins":case"min":case"m":return r*u;case"seconds":case"second":case"secs":case"sec":case"s":return r*a;case"milliseconds":case"millisecond":case"msecs":case"msec":case"ms":return r;default:return}}}}function n(t){return t>=s?Math.round(t/s)+"d":t>=c?Math.round(t/c)+"h":t>=u?Math.round(t/u)+"m":t>=a?Math.round(t/a)+"s":t+"ms"}function o(t){return i(t,s,"day")||i(t,c,"hour")||i(t,u,"minute")||i(t,a,"second")||t+" ms"}function i(t,e,r){if(!(t<e))return t<1.5*e?Math.floor(t/e)+" "+r:Math.ceil(t/e)+" "+r+"s"}var a=1e3,u=60*a,c=60*u,s=24*c,l=365.25*s;t.exports=function(t,e){e=e||{};var i=typeof t;if("string"===i&&t.length>0)return r(t);if("number"===i&&!1===isNaN(t))return e.long?o(t):n(t);throw new Error("val is not a non-empty string or a valid number. val="+JSON.stringify(t))}},GXmR:function(t,e,r){var n,o,i,a,u,c,s,l,p=function(t,e){function r(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},f={}.hasOwnProperty;r("4kSj"),n=r("aGLy"),r("y11e"),i=r("iuxk").DefaultAppletLayout,c=r("NOnk").navbar_set_active,s=r("SiCa"),l=r("9w6x"),a=n.Radio.channel("global"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.init_page=function(){},e.prototype.scroll_top=l,e.prototype.navigate_to_url=s,e.prototype.navbar_set_active=c,e}(n.Marionette.Object),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.layoutClass=i,e.prototype._get_applet=function(){var t;return t=a.request("main:app:object"),t.getView().getRegion("applet")},e.prototype.setup_layout=function(){var t;return this.layout=new this.layoutClass,t=this._get_applet(),t.hasView()&&t.empty(),t.show(this.layout)},e.prototype.setup_layout_if_needed=function(){return void 0===this.layout?this.setup_layout():this.layout.isDestroyed()?this.setup_layout():void 0},e.prototype._get_region=function(t){return this.layout.getRegion(t)},e.prototype._show_content=function(t){var e;return console.warn("_show_content is deprecated"),e=this._get_region("content"),e.show(t)},e.prototype._empty_sidebar=function(){var t;return t=this._get_region("sidebar"),t.empty(),t},e.prototype._make_sidebar=function(){var t,e;return console.warn("_make_sidebar is deprecated"),t=this._empty_sidebar(),e=new this.sidebarclass({model:this.sidebar_model}),t.show(e)},e.prototype._show_view=function(t,e){var r;return r=new t({model:e}),this.layout.showChildView("content",r)},e.prototype._load_view=function(t,e,r){var n;return e.isEmpty()||1===Object.keys(e.attributes).length?(n=e.fetch(),n.done(function(r){return function(){return r._show_view(t,e)}}(this)),n.fail(function(t){return function(){var t;return t="Failed to load "+r+" data.",MessageChannel.request("danger",t)}}())):this._show_view(t,e)},e}(o),t.exports={BaseController:o,MainController:u}},NOnk:function(t,e,r){var n,o,i,a;n=r("4kSj"),r("aGLy"),o=function(t,e,r){var n;return n=new r,t.reply("main-controller",function(){return n}),new e({controller:n})},i=function(t,e){return t.reply("get-navbar-color",function(){var t;return t=n(e),t.css("color")}),t.reply("get-navbar-bg-color",function(){var t;return t=n(e),t.css("background-color")})},a=function(t){var e,r,o,i,a,u,c;for(a=t.split("/")[0],u=n("#navbar-view li"),c=[],e=0,r=u.length;e<r;e++)o=u[e],i=n(o),i.removeClass("active"),a===i.attr("appname")?c.push(i.addClass("active")):c.push(void 0);return c},t.exports={create_new_approuter:o,navbar_color_handlers:i,navbar_set_active:a}},SiCa:function(t,e,r){var n;n=r("aGLy"),t.exports=function(t){var e;return""===t.split("/")[0]?window.location=t:(e=new n.Router,e.navigate(t,{trigger:!0}))}},X1eX:function(t,e,r){var n,o,i,a,u,c,s,l,p,f,y=function(t,e){function r(){this.constructor=t}for(var n in e)d.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},d={}.hasOwnProperty;n=r("aGLy"),f=r("mw3O"),o=n.Radio.channel("hubby"),l="https://infidel-frobozz.rhcloud.com/api/dev/lgr",s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.url=function(){return l+"/meetings/"+this.id},e}(n.Model),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.url=function(){return l+"/meetings/"+this.id},e}(n.Model),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.model=s,e.prototype.url=l+"/meetings",e}(n.Collection),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.url=function(){return l+"/items/"+this.id},e}(n.Model),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return y(e,t),e.prototype.model=c,e.prototype.url=function(){return l+"/items/search?"+f.stringify(this.searchParams)},e}(n.Collection),p=new u,o.reply("meetinglist",function(){return p}),t.exports={apiroot:l,MeetingCollection:u,MainMeetingModel:a,ItemCollection:i}},XgCd:function(t,e,r){"use strict";var n=String.prototype.replace,o=/%20/g;t.exports={default:"RFC3986",formatters:{RFC1738:function(t){return n.call(t,o,"+")},RFC3986:function(t){return t}},RFC1738:"RFC1738",RFC3986:"RFC3986"}},Zu8L:function(t,e,r){var n,o,i,a=function(t,e){function r(){this.constructor=t}for(var n in e)u.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},u={}.hasOwnProperty;n=r("aGLy"),r("y11e"),n.Radio.channel("global"),o=r("l9Gg"),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return a(e,t),e.prototype.onDomRefresh=function(){var t;return t=new o,this.view.showChildView("content",t)},e}(n.Marionette.Behavior),t.exports=i},agle:function(t,e,r){var n,o,i=function(t,e){function r(){this.constructor=t}for(var n in e)a.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},a={}.hasOwnProperty;r("y11e"),o=r("HWfR"),Backbone.Radio.channel("global"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.onBeforeStart=function(){var t,e;if(e=new this.Controller,e.applet=this,this.router=new this.Router({controller:e}),null!=this?this.appRoutes:void 0)return t=("function"==typeof this.appRoutes?this.appRoutes():void 0)||this.appRoutes,Object.keys(t).forEach(function(e){return function(r){return e.router.appRoute(r,t[r])}}(this))},e.prototype.onStop=function(){return console.log("Stopping TkApplet",this.isRunning())},e}(o.App),t.exports=n},iuxk:function(t,e,r){var n,o,i,a,u,c,s,l,p=function(t,e){function r(){this.constructor=t}for(var n in e)f.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},f={}.hasOwnProperty;n=r("aGLy"),r("y11e"),l=r("2mEY"),s=r("EarI"),o=r("Zu8L"),a=r("yk0R"),c=function(t,e,r){return null==t&&(t=3),null==e&&(e="sm"),null==r&&(r="left"),l.renderable(function(){if("left"===r&&l.div("#sidebar.col-"+e+"-"+t+".left-column"),l.div("#main-content.col-"+e+"-"+(12-t)),"right"===r)return l.div("#sidebar.col-"+e+"-"+t+".right-column")})},i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.template=c(),e.prototype.regions={sidebar:"#sidebar",content:"#main-content"},e}(n.Marionette.View),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.behaviors={ShowInitialEmptyContent:{behaviorClass:o}},e.prototype.template=l.renderable(function(){return l.div(".col-sm-12",function(){return l.div(".row",function(){return l.div("#main-toolbar.col-sm-8.col-sm-offset-2")}),l.div(".row",function(){return l.div("#main-content.col-sm-10.col-sm-offset-1")})})}),e.prototype.regions=function(){var t;return t=new a({el:"#main-content"}),t.slide_speed=s(".01s"),{content:t,toolbar:"#main-toolbar"}},e}(n.Marionette.View),t.exports={SidebarAppletLayout:i,ToolbarAppletLayout:u}},l9Gg:function(t,e,r){var n,o,i,a=function(t,e){function r(){this.constructor=t}for(var n in e)u.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},u={}.hasOwnProperty;n=r("aGLy"),r("y11e"),i=r("2mEY"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return a(e,t),e.prototype.template=i.renderable(function(){return i.div(".jumbotron",function(){return i.h1(function(){return i.text("Loading ..."),i.i(".fa.fa-spinner.fa-spin")})})}),e}(n.Marionette.View),t.exports=o},mw3O:function(t,e,r){"use strict";var n=r("CwSZ"),o=r("DDCP"),i=r("XgCd");t.exports={formats:i,parse:o,stringify:n}},p8xL:function(t,e,r){"use strict";var n=Object.prototype.hasOwnProperty,o=function(){for(var t=[],e=0;e<256;++e)t.push("%"+((e<16?"0":"")+e.toString(16)).toUpperCase());return t}();e.arrayToObject=function(t,e){for(var r=e&&e.plainObjects?Object.create(null):{},n=0;n<t.length;++n)void 0!==t[n]&&(r[n]=t[n]);return r},e.merge=function(t,r,o){if(!r)return t;if("object"!=typeof r){if(Array.isArray(t))t.push(r);else{if("object"!=typeof t)return[t,r];(o.plainObjects||o.allowPrototypes||!n.call(Object.prototype,r))&&(t[r]=!0)}return t}if("object"!=typeof t)return[t].concat(r);var i=t;return Array.isArray(t)&&!Array.isArray(r)&&(i=e.arrayToObject(t,o)),Array.isArray(t)&&Array.isArray(r)?(r.forEach(function(r,i){n.call(t,i)?t[i]&&"object"==typeof t[i]?t[i]=e.merge(t[i],r,o):t.push(r):t[i]=r}),t):Object.keys(r).reduce(function(t,n){var i=r[n];return Object.prototype.hasOwnProperty.call(t,n)?t[n]=e.merge(t[n],i,o):t[n]=i,t},i)},e.decode=function(t){try{return decodeURIComponent(t.replace(/\+/g," "))}catch(e){return t}},e.encode=function(t){if(0===t.length)return t;for(var e="string"==typeof t?t:String(t),r="",n=0;n<e.length;++n){var i=e.charCodeAt(n);45===i||46===i||95===i||126===i||i>=48&&i<=57||i>=65&&i<=90||i>=97&&i<=122?r+=e.charAt(n):i<128?r+=o[i]:i<2048?r+=o[192|i>>6]+o[128|63&i]:i<55296||i>=57344?r+=o[224|i>>12]+o[128|i>>6&63]+o[128|63&i]:(n+=1,i=65536+((1023&i)<<10|1023&e.charCodeAt(n)),r+=o[240|i>>18]+o[128|i>>12&63]+o[128|i>>6&63]+o[128|63&i])}return r},e.compact=function(t,r){if("object"!=typeof t||null===t)return t;var n=r||[],o=n.indexOf(t);if(-1!==o)return n[o];if(n.push(t),Array.isArray(t)){for(var i=[],a=0;a<t.length;++a)t[a]&&"object"==typeof t[a]?i.push(e.compact(t[a],n)):void 0!==t[a]&&i.push(t[a]);return i}return Object.keys(t).forEach(function(r){t[r]=e.compact(t[r],n)}),t},e.isRegExp=function(t){return"[object RegExp]"===Object.prototype.toString.call(t)},e.isBuffer=function(t){return null!==t&&void 0!==t&&!!(t.constructor&&t.constructor.isBuffer&&t.constructor.isBuffer(t))}},yk0R:function(t,e,r){var n,o,i=function(t,e){function r(){this.constructor=t}for(var n in e)a.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},a={}.hasOwnProperty;r("4kSj"),n=r("y11e"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.attachHtml=function(t){var e;return e=this.slide_speed?this.slide_speed:"fast",this.$el.hide(),this.$el.html(t.el),this.$el.slideDown(e)},e}(n.Region),t.exports=o}});