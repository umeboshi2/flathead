webpackJsonp([3],{"1xar":function(t,e,r){var o,n,s,i,a,u,l,c,p,h,f,_,y,d,g=function(t,e){function r(){this.constructor=t}for(var o in e)m.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},m={}.hasOwnProperty;o=r("aGLy"),r("y11e"),l=r("OhLM"),n=r("sJcH").BaseLocalStorageCollection,u=r("KIRP"),o.Radio.channel("global"),i=o.Radio.channel("bumblr"),h="//api.tumblr.com/v2",c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return g(e,t),e.prototype.url=function(){return h+"/"+this.id+"/posts/photo?callback=?"},e}(o.Collection),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return g(e,t),e.prototype.mode="server",e.prototype.full=!0,e.prototype.baseURL=h,e.prototype.url=function(){return this.baseURL+"/blog/"+this.base_hostname+"/posts/photo?api_key="+this.api_key},e.prototype.fetch=function(t){var r,o;return t||(t={}),t.data||{},r=this.state.currentPage,o=r*this.state.pageSize,t.offset=o,t.dataType="jsonp",e.__super__.fetch.call(this,t)},e.prototype.parse=function(t){var r;return r=t.response.total_posts,this.state.totalRecords=r,e.__super__.parse.call(this,t.response.posts)},e.prototype.state={firstPage:0,pageSize:15},e.prototype.queryParams={pageSize:"limit",offset:function(){return this.state.currentPage*this.state.pageSize}},e}(l),_=function(t){var e,r,o;return o=i.request("get_app_settings"),e=o.get("consumer_key"),r=new s,r.api_key=e,r.base_hostname=t,r},y="make_blog_post_collection",i.reply(y,function(t){return _(t)}),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return g(e,t),e.prototype.model=u.BlogInfo,e.prototype.add_blog=function(t){var e,r;return r=t+".tumblr.com",e=new u.BlogInfo,e.set("id",r),e.set("name",t),e.api_key=this.api_key,this.add(e),this.save(),e.fetch(),e},e}(n),f=new a,d=i.request("get_app_settings"),p=d.get("consumer_key"),f.api_key=p,i.reply("get_local_blogs",function(){return f}),t.exports={PhotoPostCollection:c}},"9w6x":function(t,e){t.exports=function(){return window.scrollTo(0,0)}},EarI:function(t,e){function r(t){if(t=String(t),!(t.length>1e4)){var e=/^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i.exec(t);if(e){var r=parseFloat(e[1]);switch((e[2]||"ms").toLowerCase()){case"years":case"year":case"yrs":case"yr":case"y":return r*c;case"days":case"day":case"d":return r*l;case"hours":case"hour":case"hrs":case"hr":case"h":return r*u;case"minutes":case"minute":case"mins":case"min":case"m":return r*a;case"seconds":case"second":case"secs":case"sec":case"s":return r*i;case"milliseconds":case"millisecond":case"msecs":case"msec":case"ms":return r;default:return}}}}function o(t){return t>=l?Math.round(t/l)+"d":t>=u?Math.round(t/u)+"h":t>=a?Math.round(t/a)+"m":t>=i?Math.round(t/i)+"s":t+"ms"}function n(t){return s(t,l,"day")||s(t,u,"hour")||s(t,a,"minute")||s(t,i,"second")||t+" ms"}function s(t,e,r){if(!(t<e))return t<1.5*e?Math.floor(t/e)+" "+r:Math.ceil(t/e)+" "+r+"s"}var i=1e3,a=60*i,u=60*a,l=24*u,c=365.25*l;t.exports=function(t,e){e=e||{};var s=typeof t;if("string"===s&&t.length>0)return r(t);if("number"===s&&!1===isNaN(t))return e.long?n(t):o(t);throw new Error("val is not a non-empty string or a valid number. val="+JSON.stringify(t))}},GXmR:function(t,e,r){var o,n,s,i,a,u,l,c,p=function(t,e){function r(){this.constructor=t}for(var o in e)h.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},h={}.hasOwnProperty;r("4kSj"),o=r("aGLy"),r("y11e"),s=r("iuxk").DefaultAppletLayout,u=r("NOnk").navbar_set_active,l=r("SiCa"),c=r("9w6x"),i=o.Radio.channel("global"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.init_page=function(){},e.prototype.scroll_top=c,e.prototype.navigate_to_url=l,e.prototype.navbar_set_active=u,e}(o.Marionette.Object),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.layoutClass=s,e.prototype._get_applet=function(){var t;return t=i.request("main:app:object"),t.getView().getRegion("applet")},e.prototype.setup_layout=function(){var t;return this.layout=new this.layoutClass,t=this._get_applet(),t.hasView()&&t.empty(),t.show(this.layout)},e.prototype.setup_layout_if_needed=function(){return void 0===this.layout?this.setup_layout():this.layout.isDestroyed()?this.setup_layout():void 0},e.prototype._get_region=function(t){return this.layout.getRegion(t)},e.prototype._show_content=function(t){var e;return console.warn("_show_content is deprecated"),e=this._get_region("content"),e.show(t)},e.prototype._empty_sidebar=function(){var t;return t=this._get_region("sidebar"),t.empty(),t},e.prototype._make_sidebar=function(){var t,e;return console.warn("_make_sidebar is deprecated"),t=this._empty_sidebar(),e=new this.sidebarclass({model:this.sidebar_model}),t.show(e)},e.prototype._show_view=function(t,e){var r;return r=new t({model:e}),this.layout.showChildView("content",r)},e.prototype._load_view=function(t,e,r){var o;return e.isEmpty()||1===Object.keys(e.attributes).length?(o=e.fetch(),o.done(function(r){return function(){return r._show_view(t,e)}}(this)),o.fail(function(t){return function(){var t;return t="Failed to load "+r+" data.",MessageChannel.request("danger",t)}}())):this._show_view(t,e)},e}(n),t.exports={BaseController:n,MainController:a}},Gncq:function(t,e,r){var o,n,s,i,a,u,l,c=function(t,e){function r(){this.constructor=t}for(var o in e)p.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},p={}.hasOwnProperty;a=r("y11e"),l=r("agle"),s=r("iopH"),i=Backbone.Radio.channel("global"),n=Backbone.Radio.channel("bumblr"),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.appRoutes={bumblr:"start","bumblr/settings":"settings_page","bumblr/dashboard":"show_dashboard","bumblr/listblogs":"list_blogs","bumblr/viewblog/:id":"view_blog","bumblr/addblog":"add_new_blog"},e}(a.AppRouter),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.Controller=s,e.prototype.Router=u,e.prototype.onBeforeStart=function(){var t;return t=n.request("get_local_blogs"),t.fetch(),e.__super__.onBeforeStart.call(this,arguments)},e}(l),i.reply("applet:bumblr:route",function(){var t,e;return console.warn("Don't use applet:bumblr:route"),e=new s(i),t=n.request("get_local_blogs"),t.fetch(),new u({controller:e})}),t.exports=o},KIRP:function(t,e,r){var o,n,s,i,a,u,l,c,p,h=function(t,e){function r(){this.constructor=t}for(var o in e)f.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},f={}.hasOwnProperty;o=r("aGLy"),a=o.Radio.channel("bumblr"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.initialize=function(){return this.fetch(),this.on("change",this.save,this)},e.prototype.fetch=function(){return this.set(JSON.parse(localStorage.getItem(this.id)))},e.prototype.save=function(t,e){return localStorage.setItem(this.id,JSON.stringify(this.toJSON())),$.ajax({success:e.success,error:e.error})},e.prototype.destroy=function(t){return localStorage.removeItem(this.id)},e.prototype.isEmpty=function(){return _.size(this.attributes<=1)},e}(o.Model),l="//api.tumblr.com/v2",u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.id="bumblr_settings",e}(n),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.baseURL=l,e}(o.Model),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.url=function(){return this.baseURL+"/blog/"+this.id+"/info?api_key="+this.api_key+"&callback=?"},e}(s),p="4mhV8B1YQK6PUA2NW8eZZXVHjU55TPJ3UZnZGrbSoCnqJaxDyH",c=new u({consumer_key:p}),a.reply("get_app_settings",function(){return c}),t.exports={BlogInfo:i}},LcSZ:function(t,e,r){var o,n,s,i,a,u,l=function(t,e){function r(){this.constructor=t}for(var o in e)c.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},c={}.hasOwnProperty;o=r("aGLy"),r("y11e"),u=r("2mEY"),o.Radio.channel("bumblr"),a=u.renderable(function(t){return u.p("main bumblr view")}),i=u.renderable(function(t){return u.p("bumblr_dashboard_view")}),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.template=a,e}(o.Marionette.View),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.template=i,e}(o.Marionette.View),t.exports={MainBumblrView:s,BumblrDashboardView:n}},NOnk:function(t,e,r){var o,n,s,i;o=r("4kSj"),r("aGLy"),n=function(t,e,r){var o;return o=new r,t.reply("main-controller",function(){return o}),new e({controller:o})},s=function(t,e){return t.reply("get-navbar-color",function(){var t;return t=o(e),t.css("color")}),t.reply("get-navbar-bg-color",function(){var t;return t=o(e),t.css("background-color")})},i=function(t){var e,r,n,s,i,a,u;for(i=t.split("/")[0],a=o("#navbar-view li"),u=[],e=0,r=a.length;e<r;e++)n=a[e],s=o(n),s.removeClass("active"),i===s.attr("appname")?u.push(s.addClass("active")):u.push(void 0);return u},t.exports={create_new_approuter:n,navbar_color_handlers:s,navbar_set_active:i}},OhLM:function(t,e,r){/*
  backbone.paginator
  http://github.com/backbone-paginator/backbone.paginator

  Copyright (c) 2016 Jimmy Yuen Ho Wong and contributors

  @module
  @license MIT
*/
!function(e){t.exports=e(r("rdLu"),r("aGLy"))}(function(t,e){"use strict";function r(e,r){if(!t.isNumber(e)||t.isNaN(e)||!t.isFinite(e)||~~e!==e)throw new TypeError("`"+r+"` must be a finite integer");return e}function o(t){for(var e,r,o,n,s={},i=decodeURIComponent,a=t.split("&"),u=0,l=a.length;u<l;u++){e=a[u].split("="),r=e[0],o=e[1],null==o&&(o=!0),r=i(r),o=i(o),n=s[r],_(n)?n.push(o):s[r]=n?[n,o]:o}return s}function n(t,e,r){var o=t._events[e];if(o&&o.length){var n=o[o.length-1],s=n.callback;n.callback=function(){try{s.apply(this,arguments),r()}catch(t){throw t}finally{n.callback=s}}}else r()}var s=t.extend,i=t.omit,a=t.clone,u=t.each,l=t.pick,c=t.includes,p=t.isEmpty,h=t.pairs||t.toPairs,f=t.invert,_=t.isArray,y=t.isFunction,d=t.isObject,g=t.keys,m=t.isUndefined,v=Math.ceil,b=Math.floor,w=Math.max,P=e.Collection.prototype,k=/[\s'"]/g,R=/[<>\s'"]/g,S=e.PageableCollection=e.Collection.extend({state:{firstPage:1,lastPage:null,currentPage:null,pageSize:25,totalPages:null,totalRecords:null,sortKey:null,order:-1},mode:"server",queryParams:{currentPage:"page",pageSize:"per_page",totalPages:"total_pages",totalRecords:"total_entries",sortKey:"sort_by",order:"order",directions:{"-1":"asc",1:"desc"}},constructor:function(t,e){P.constructor.apply(this,arguments),e=e||{};var r=this.mode=e.mode||this.mode||C.mode,o=s({},C.queryParams,this.queryParams,e.queryParams||{});o.directions=s({},C.queryParams.directions,this.queryParams.directions,o.directions),this.queryParams=o;var n=this.state=s({},C.state,this.state,e.state);n.currentPage=null==n.currentPage?n.firstPage:n.currentPage,_(t)||(t=t?[t]:[]),t=t.slice(),"server"==r||null!=n.totalRecords||p(t)||(n.totalRecords=this.length),this.switchMode(r,s({fetch:!1,resetState:!1,models:t},e));var i=e.comparator;if(n.sortKey&&!i&&this.setSorting(n.sortKey,n.order,e),"server"!=r){var u=this.fullCollection;i&&e.full&&(this.comparator=null,u.comparator=i),e.full&&u.sort(),p(t)||this.getPage(n.currentPage)}this._initState=a(this.state)},_makeFullCollection:function(t,r){var o,n,s,i=["url","model","sync","comparator"],a=this.constructor.prototype,u={};for(o=0,n=i.length;o<n;o++)s=i[o],m(a[s])||(u[s]=a[s]);var l=new(e.Collection.extend(u))(t,r);for(o=0,n=i.length;o<n;o++)s=i[o],this[s]!==a[s]&&(l[s]=this[s]);return l},_makeCollectionEventHandler:function(t,e){return function(r,o,i,l){var c=t._handlers;u(g(c),function(r){var o=c[r];t.off(r,o),e.off(r,o)});var p=a(t.state),h=p.firstPage,f=0===h?p.currentPage:p.currentPage-1,_=p.pageSize,y=f*_,d=y+_;if("add"==r){var b,w,P,k,l=l||{};if(i==e)(w=e.indexOf(o))>=y&&w<d&&(k=t,b=P=w-y);else{b=t.indexOf(o),w=y+b,k=e;var P=m(l.at)?w:l.at+y}if(l.onRemove||(++p.totalRecords,delete l.onRemove),t.state=t._checkState(p),k){k.add(o,s({},l,{at:P}));var R=b>=_?o:!m(l.at)&&P<d&&t.length>_?t.at(_):null;R&&n(i,r,function(){t.remove(R,{onAdd:!0})})}l.silent||t.trigger("pageable:state:change",t.state)}if("remove"==r){if(l.onAdd)delete l.onAdd;else{if(--p.totalRecords){var S=p.totalPages=v(p.totalRecords/_);p.lastPage=0===h?S-1:S||h,p.currentPage>S&&(p.currentPage=p.lastPage)}else p.totalRecords=null,p.totalPages=null;t.state=t._checkState(p);var C,x=l.index;i==t?((C=e.at(d))?n(t,r,function(){t.push(C,{onRemove:!0})}):!t.length&&p.totalRecords&&t.reset(e.models.slice(y-_,d-_),s({},l,{parse:!1})),e.remove(o)):x>=y&&x<d&&((C=e.at(d-1))&&n(t,r,function(){t.push(C,{onRemove:!0})}),t.remove(o),!t.length&&p.totalRecords&&t.reset(e.models.slice(y-_,d-_),s({},l,{parse:!1})))}l.silent||t.trigger("pageable:state:change",t.state)}if("reset"==r){if(l=i,(i=o)==t&&null==l.from&&null==l.to){var L=e.models.slice(0,y),q=e.models.slice(y+t.models.length);e.reset(L.concat(t.models).concat(q),l)}else i==e&&((p.totalRecords=e.models.length)||(p.totalRecords=null,p.totalPages=null),"client"==t.mode&&(h=p.lastPage=p.currentPage=p.firstPage,f=0===h?p.currentPage:p.currentPage-1,y=f*_,d=y+_),t.state=t._checkState(p),t.reset(e.models.slice(y,d),s({},l,{parse:!1})));l.silent||t.trigger("pageable:state:change",t.state)}"sort"==r&&(l=i,(i=o)===e&&t.reset(e.models.slice(y,d),s({},l,{parse:!1}))),u(g(c),function(r){var o=c[r];u([t,e],function(t){t.on(r,o);var e=t._events[r]||[];e.unshift(e.pop())})})}},_checkState:function(t){var e=this.mode,o=this.links,n=t.totalRecords,s=t.pageSize,i=t.currentPage,a=t.firstPage,u=t.totalPages;if(null!=n&&null!=s&&null!=i&&null!=a&&("infinite"!=e||o)){if(n=r(n,"totalRecords"),s=r(s,"pageSize"),i=r(i,"currentPage"),a=r(a,"firstPage"),s<1)throw new RangeError("`pageSize` must be >= 1");if(u=t.totalPages=v(n/s),a<0||a>1)throw new RangeError("`firstPage must be 0 or 1`");if(t.lastPage=0===a?w(0,u-1):u||a,"infinite"==e){if(!o[i])throw new RangeError("No link found for page "+i)}else if(i<a||u>0&&(a?i>u:i>=u))throw new RangeError("`currentPage` must be firstPage <= currentPage "+(a?"<":"<=")+" totalPages if "+a+"-based. Got "+i+".")}return t},setPageSize:function(t,e){t=r(t,"pageSize"),e=e||{first:!1};var o=this.state,n=v(o.totalRecords/t),a=n?w(o.firstPage,b(n*o.currentPage/o.totalPages)):o.firstPage;return o=this.state=this._checkState(s({},o,{pageSize:t,currentPage:e.first?o.firstPage:a,totalPages:n})),this.getPage(o.currentPage,i(e,["first"]))},switchMode:function(e,r){if(!c(["server","client","infinite"],e))throw new TypeError('`mode` must be one of "server", "client" or "infinite"');r=r||{fetch:!0,resetState:!0};var o=this.state=r.resetState?a(this._initState):this._checkState(s({},this.state));this.mode=e;var n,l=this,p=this.fullCollection,h=this._handlers=this._handlers||{};if("server"==e||p)"server"==e&&p&&(u(g(h),function(t){n=h[t],l.off(t,n),p.off(t,n)}),delete this._handlers,this._fullComparator=p.comparator,delete this.fullCollection);else{p=this._makeFullCollection(r.models||[],r),p.pageableCollection=this,this.fullCollection=p;var f=this._makeCollectionEventHandler(this,p);u(["add","remove","reset","sort"],function(e){h[e]=n=t.bind(f,{},e),l.on(e,n),p.on(e,n)}),p.comparator=this._fullComparator}if("infinite"==e)for(var _=this.links={},y=o.firstPage,d=v(o.totalRecords/o.pageSize),m=0===y?w(0,d-1):d||y,b=o.firstPage;b<=m;b++)_[b]=this.url;else this.links&&delete this.links;return r.silent||this.trigger("pageable:state:change",o),r.fetch?this.fetch(i(r,"fetch","resetState")):this},hasPreviousPage:function(){var t=this.state,e=t.currentPage;return"infinite"!=this.mode?e>t.firstPage:!!this.links[e-1]},hasNextPage:function(){var t=this.state,e=this.state.currentPage;return"infinite"!=this.mode?e<t.lastPage:!!this.links[e+1]},getFirstPage:function(t){return this.getPage("first",t)},getPreviousPage:function(t){return this.getPage("prev",t)},getNextPage:function(t){return this.getPage("next",t)},getLastPage:function(t){return this.getPage("last",t)},getPage:function(t,e){var o=this.mode,n=this.fullCollection;e=e||{fetch:!1};var a=this.state,u=a.firstPage,l=a.currentPage,c=a.lastPage,h=a.pageSize,f=t;switch(t){case"first":f=u;break;case"prev":f=l-1;break;case"next":f=l+1;break;case"last":f=c;break;default:f=r(t,"index")}this.state=this._checkState(s({},a,{currentPage:f})),e.silent||this.trigger("pageable:state:change",this.state),e.from=l,e.to=f;var _=(0===u?f:f-1)*h,y=n&&n.length?n.models.slice(_,_+h):[];return"client"!=o&&("infinite"!=o||p(y))||e.fetch?("infinite"==o&&(e.url=this.links[f]),this.fetch(i(e,"fetch"))):(this.reset(y,i(e,"fetch")),this)},getPageByOffset:function(t,e){if(t<0)throw new RangeError("`offset must be > 0`");t=r(t,"offset");var o=b(t/this.state.pageSize);return 0!==this.state.firstPage&&o++,o>this.state.lastPage&&(o=this.state.lastPage),this.getPage(o,e)},sync:function(t,r,o){var n=this;if("infinite"==n.mode){var i=o.success,a=n.state.currentPage;o.success=function(t,e,r){var u=n.links,l=n.parseLinks(t,s({xhr:r},o));l.first&&(u[n.state.firstPage]=l.first),l.prev&&(u[a-1]=l.prev),l.next&&(u[a+1]=l.next),i&&i(t,e,r)}}return(P.sync||e.sync).call(n,t,r,o)},parseLinks:function(t,e){var r={},o=e.xhr.getResponseHeader("Link");if(o){var n=["first","prev","next"];u(o.split(","),function(t){var e=t.split(";"),o=e[0].replace(R,""),s=e.slice(1);u(s,function(t){var e=t.split("="),s=e[0].replace(k,""),i=e[1].replace(k,"");"rel"==s&&c(n,i)&&(r[i]=o)})})}return r},parse:function(t,e){var r=this.parseState(t,a(this.queryParams),a(this.state),e);return r&&(this.state=this._checkState(s({},this.state,r)),(e||{}).silent||this.trigger("pageable:state:change",this.state)),this.parseRecords(t,e)},parseState:function(e,r,o,n){if(e&&2===e.length&&d(e[0])&&_(e[1])){var s=a(o),l=e[0];return u(h(i(r,"directions")),function(e){var r=e[0],o=e[1],n=l[o];m(n)||t.isNull(n)||(s[r]=l[o])}),l.order&&(s.order=1*f(r.directions)[l.order]),s}},parseRecords:function(t,e){return t&&2===t.length&&d(t[0])&&_(t[1])?t[1]:t},fetch:function(e){e=e||{};var r=this._checkState(this.state),n=this.mode;"infinite"!=n||e.url||(e.url=this.links[r.currentPage]);var a=e.data||{},c=e.url||this.url||"";y(c)&&(c=c.call(this));var p=c.indexOf("?");-1!=p&&(s(a,o(c.slice(p+1))),c=c.slice(0,p)),e.url=c,e.data=a;var f="client"==this.mode?l(this.queryParams,"sortKey"):i(l(this.queryParams,g(C.queryParams)),"order","directions","totalPages","totalRecords");u(f,function(e,o){e=y(e)?e.call(this):e,null!=r[o]&&null!=e&&t.isUndefined(a[e])&&(a[e]=r[o])},this);var d=y(this.queryParams.sortKey)?this.queryParams.sortKey.call(this):this.queryParams.sortKey,v=y(this.queryParams.order)?this.queryParams.order.call(this):this.queryParams.order;if(null!=d&&null!=r.sortKey&&null!=v&&null!=r.order)if(_(r.order)){a[v]=[];for(var b=0;b<r.order.length;b++)a[v].push(this.queryParams.directions[r.order[b]])}else a[v]=this.queryParams.directions[r.order+""];for(var w=h(i(this.queryParams,g(C.queryParams))),b=0;b<w.length;b++){var k=w[b],R=k[1];R=y(R)?R.call(this):R,null!=R&&(a[k[0]]=R)}if("server"!=n){var S=this,x=this.fullCollection,L=e.success;return e.success=function(t,r,o){o=o||{},m(e.silent)?delete o.silent:o.silent=e.silent;var i=t.models;"client"==n?x.reset(i,o):(x.add(i,s({at:x.length},s(o,{parse:!1}))),S.trigger("reset",S,o)),L&&L(t,r,o)},P.fetch.call(this,s({},e,{silent:!0}))}return P.fetch.call(this,e)},_makeComparator:function(t,e,r){var o=this.state;if(t=t||o.sortKey,e=e||o.order,t&&e)return r||(r=function(t,e){return t.get(e)}),function(o,n){var s,i=r(o,t),a=r(n,t);return 1===e&&(s=i,i=a,a=s),i===a?0:i<a?-1:1}},setSorting:function(t,e,r){var o=this.state;o.sortKey=t,o.order=e=e||o.order;var n=this.fullCollection,i=!1,a=!1;t||(i=a=!0);var u=this.mode;r=s({side:"client"==u?u:"server",full:!0},r);var l=this._makeComparator(t,e,r.sortValue),c=r.full,p=r.side;return"client"==p?c?(n&&(n.comparator=l),i=!0):(this.comparator=l,a=!0):"server"!=p||c||(this.comparator=l),i&&(this.comparator=null),a&&n&&(n.comparator=null),this}}),C=S.prototype;return S})},SiCa:function(t,e,r){var o;o=r("aGLy"),t.exports=function(t){var e;return""===t.split("/")[0]?window.location=t:(e=new o.Router,e.navigate(t,{trigger:!0}))}},Zu8L:function(t,e,r){var o,n,s,i=function(t,e){function r(){this.constructor=t}for(var o in e)a.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},a={}.hasOwnProperty;o=r("aGLy"),r("y11e"),o.Radio.channel("global"),n=r("l9Gg"),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.onDomRefresh=function(){var t;return t=new n,this.view.showChildView("content",t)},e}(o.Marionette.Behavior),t.exports=s},agle:function(t,e,r){var o,n,s=function(t,e){function r(){this.constructor=t}for(var o in e)i.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},i={}.hasOwnProperty;r("y11e"),n=r("HWfR"),Backbone.Radio.channel("global"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.onBeforeStart=function(){var t,e;if(e=new this.Controller,e.applet=this,this.router=new this.Router({controller:e}),null!=this?this.appRoutes:void 0)return t=("function"==typeof this.appRoutes?this.appRoutes():void 0)||this.appRoutes,Object.keys(t).forEach(function(e){return function(r){return e.router.appRoute(r,t[r])}}(this))},e.prototype.onStop=function(){return console.log("Stopping TkApplet",this.isRunning())},e}(n.App),t.exports=o},iopH:function(t,e,r){var o,n,s,i,a,u,l,c,p,h,f,_,y,d=function(t,e){function r(){this.constructor=t}for(var o in e)g.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},g={}.hasOwnProperty;o=r("4kSj"),n=r("aGLy"),r("y11e"),f=r("2mEY"),h=r("9w6x"),p=r("SiCa"),a=r("GXmR").MainController,l=r("iuxk").ToolbarAppletLayout,r("KIRP"),r("1xar"),u=r("LcSZ"),s=n.Radio.channel("bumblr"),_=new n.Model({entries:[{name:"List Blogs",url:"#bumblr/listblogs",icon:"list"},{name:"Settings",url:"#bumblr/settings",icon:"gear"}]}),y=f.renderable(function(t){return f.div(".btn-group.btn-group-justified",function(){var e,r,o,n,s;for(n=t.entries,s=[],r=0,o=n.length;r<o;r++)e=n[r],s.push(f.div(".toolbar-button.btn.btn-default",{"button-url":e.url},function(){return f.span(".fa.fa-"+e.icon," "+e.name)}));return s})}),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return d(e,t),e.prototype.template=y,e.prototype.ui={toolbarButton:".toolbar-button"},e.prototype.events={"click @ui.toolbarButton":"toolbarButtonPressed"},e.prototype.toolbarButtonPressed=function(t){var e;return console.log("toolbarButtonPressed",t),e=t.currentTarget.getAttribute("button-url"),p(e)},e}(n.Marionette.View),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return d(e,t),e.prototype.layoutClass=l,e.prototype.setup_layout_if_needed=function(){var t;return e.__super__.setup_layout_if_needed.call(this),t=new c({model:_}),this.layout.showChildView("toolbar",t)},e.prototype.set_header=function(t){var e;return e=o("#header"),e.text(t)},e.prototype.start=function(){return this.setup_layout_if_needed(),this.set_header("Bumblr"),this.list_blogs()},e.prototype.default_view=function(){return this.start()},e.prototype.show_mainview=function(){var t;return t=new u.MainBumblrView,this.layout.showChildView("content",t),h()},e.prototype.show_dashboard=function(){var t;return t=new u.BumblrDashboardView,this.layout.showChildView("content",t),h()},e.prototype.list_blogs=function(){return this.setup_layout_if_needed(),r.e(13).then(function(t){return function(){var e,o,n;return o=s.request("get_local_blogs"),e=r("4i3l"),n=new e({collection:o}),t.layout.showChildView("content",n)}}(this).bind(null,r)).catch(r.oe)},e.prototype.view_blog=function(t){return this.setup_layout_if_needed(),r.e(13).then(function(e){return function(){var o,n,i,a;return i=t+".tumblr.com",n=s.request("make_blog_post_collection",i),o=r("QSsu"),a=n.fetch(),a.done(function(){var t;return t=new o({collection:n}),e.layout.showChildView("content",t),h()})}}(this).bind(null,r)).catch(r.oe)},e.prototype.add_new_blog=function(){return this.setup_layout_if_needed(),r.e(10).then(function(t){return function(){var e,o;return e=r("Rif3"),o=new e,t.layout.showChildView("content",o),h()}}(this).bind(null,r)).catch(r.oe)},e.prototype.settings_page=function(){return this.setup_layout_if_needed(),r.e(10).then(function(t){return function(){var e,o,n;return e=r("jry7"),o=s.request("get_app_settings"),n=new e({model:o}),t.layout.showChildView("content",n),h()}}(this).bind(null,r)).catch(r.oe)},e}(a),t.exports=i},iuxk:function(t,e,r){var o,n,s,i,a,u,l,c,p=function(t,e){function r(){this.constructor=t}for(var o in e)h.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},h={}.hasOwnProperty;o=r("aGLy"),r("y11e"),c=r("2mEY"),l=r("EarI"),n=r("Zu8L"),i=r("yk0R"),u=function(t,e,r){return null==t&&(t=3),null==e&&(e="sm"),null==r&&(r="left"),c.renderable(function(){if("left"===r&&c.div("#sidebar.col-"+e+"-"+t+".left-column"),c.div("#main-content.col-"+e+"-"+(12-t)),"right"===r)return c.div("#sidebar.col-"+e+"-"+t+".right-column")})},s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.template=u(),e.prototype.regions={sidebar:"#sidebar",content:"#main-content"},e}(o.Marionette.View),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.behaviors={ShowInitialEmptyContent:{behaviorClass:n}},e.prototype.template=c.renderable(function(){return c.div(".col-sm-12",function(){return c.div(".row",function(){return c.div("#main-toolbar.col-sm-8.col-sm-offset-2")}),c.div(".row",function(){return c.div("#main-content.col-sm-10.col-sm-offset-1")})})}),e.prototype.regions=function(){var t;return t=new i({el:"#main-content"}),t.slide_speed=l(".01s"),{content:t,toolbar:"#main-toolbar"}},e}(o.Marionette.View),t.exports={SidebarAppletLayout:s,ToolbarAppletLayout:a}},l9Gg:function(t,e,r){var o,n,s,i=function(t,e){function r(){this.constructor=t}for(var o in e)a.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},a={}.hasOwnProperty;o=r("aGLy"),r("y11e"),s=r("2mEY"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return i(e,t),e.prototype.template=s.renderable(function(){return s.div(".jumbotron",function(){return s.h1(function(){return s.text("Loading ..."),s.i(".fa.fa-spinner.fa-spin")})})}),e}(o.Marionette.View),t.exports=n},sJcH:function(t,e,r){var o,n,s=function(t,e){function r(){this.constructor=t}for(var o in e)i.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},i={}.hasOwnProperty;r("4kSj"),r("rdLu"),o=r("aGLy"),r("y11e"),o.Radio.channel("global"),o.Radio.channel("messages"),o.Radio.channel("resources"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.local_storage_key=null,e.prototype.initialize=function(){return this.fetch(),this.on("change",this.save,this)},e.prototype.fetch=function(){var t;return t=JSON.parse(localStorage.getItem(this.local_storage_key))||[],this.set(t)},e.prototype.save=function(t){return localStorage.setItem(this.local_storage_key,JSON.stringify(this.toJSON()))},e}(o.Collection),t.exports={BaseLocalStorageCollection:n}},yk0R:function(t,e,r){var o,n,s=function(t,e){function r(){this.constructor=t}for(var o in e)i.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},i={}.hasOwnProperty;r("4kSj"),o=r("y11e"),n=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.attachHtml=function(t){var e;return e=this.slide_speed?this.slide_speed:"fast",this.$el.hide(),this.$el.html(t.el),this.$el.slideDown(e)},e}(o.Region),t.exports=n}});