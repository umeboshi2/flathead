webpackJsonp([9],{"CR+N":function(t,e,n){function r(t){var e=o[t];return e?n.e(e[1]).then(function(){return n(e[0])}):Promise.reject(new Error("Cannot find module '"+t+"'."))}var o={"./bumblr/main":["Gncq",3],"./dbadmin/main":["PWmu",7],"./dbdocs/main":["R0Nh",6],"./ebcsv/main":["qAUr",0],"./frontdoor/main":["dKNP",1],"./hubby/main":["DxIB",2],"./sofi/main":["LtPu",0],"./todos/main":["oBQv",4],"./userprofile/main":["Uy6/",5]};r.keys=function(){return Object.keys(o)},t.exports=r,r.id="CR+N"},GSVz:function(t,e,n){var r,o,i,a,p,u,s,l,c,f,d,h,y,g,v,m,_,b,w=function(t,e){function n(){this.constructor=t}for(var r in e)C.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},C={}.hasOwnProperty;r=n("4kSj"),o=n("aGLy"),s=n("y11e"),v=n("HWfR"),b=n("2mEY"),u=o.Radio.channel("global"),o.Radio.channel("messages"),f=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.defaults={label:"App Label",url:"#app",single_applet:!1,applets:[],urls:[]},e}(o.Model),d=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.model=f,e}(o.Collection),_=new d,u.reply("navbar-entries",function(){return _}),u.reply("new-navbar-entry",function(){return new f}),u.reply("add-navbar-entry",function(t){return _.add(t)}),u.reply("add-navbar-entries",function(t){return _.add(t)}),m=b.renderable(function(t){return b.button(".navbar-toggle",{type:"button","data-toggle":"collapse","data-target":"#"+t},function(){return b.span(".sr-only","Toggle Navigation"),b.span(".icon-bar"),b.span(".icon-bar"),b.span(".icon-bar")})}),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.model=f,e.prototype.tagName="li",e.prototype.templateContext=function(){var t;return t=u.request("main:app:object"),{app:t,currentUser:t.getState("currentUser")}},e.prototype.ui={entry:".navbar-entry"},e.prototype.triggers={"click @ui.entry":"click:entry"},e.prototype.set_active=function(){return this.$el.addClass("active")},e.prototype.unset_active=function(){return this.$el.removeClass("active"),this.$el.removeClass("open")},e}(s.View),g=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.template=b.renderable(function(t){return b.a(".navbar-entry",{href:t.url},t.label)}),e}(i),p=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.className="dropdown",e.prototype.template=b.renderable(function(t){return b.a(".dropdown-toggle",{role:"button","data-toggle":"dropdown"},function(){return b.text(t.label),b.b(".caret")}),b.ul(".dropdown-menu",function(){var e,n,r,o,i;for(o=t.menu,i=[],e=0,n=o.length;e<n;e++)null!=(r=o[e])&&r.needUser&&!t.currentUser||i.push(b.li(function(){return b.a(".navbar-entry",{href:r.url},r.label)}));return i})}),e}(i),h=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.tagName="ul",e.prototype.className="nav navbar-nav nav-pills",e.prototype.childView=function(t){return t.has("menu")&&t.get("menu")?p:g},e.prototype.setAllInactive=function(){return this.children.each(function(t){return t.unset_active()})},e.prototype.onChildviewClickEntry=function(t,e){return this.setAllInactive(),t.set_active(),this.navigateOnClickEntry(t,e)},e.prototype.navigateOnClickEntry=function(t,e){var n,o,i;return i=e.target,n=r(i).attr("href"),""===n.split("/")[0]?window.location=n:(o=u.request("main-router"),o.navigate(n,{trigger:!0}))},e}(s.CollectionView),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.regions={list:"#navbar-entries",userMenu:"#user-menu",search:"#form-search-container"},e.prototype.onRender=function(){var t;return t=new h({collection:this.collection}),this.showChildView("list",t)},e.prototype.template=b.renderable(function(t){return b.div("#navbar-view-collapse.collapse.navbar-collapse",function(){return b.div("#navbar-entries"),b.ul("#user-menu.nav.navbar-nav.navbar-right"),b.div("#form-search-container")})}),e.prototype.setAllInactive=function(){var t;return t=this.getChildView("list"),t.setAllInactive()},e}(s.View),y=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.template=b.renderable(function(t){return m("navbar-view-collapse"),b.a(".navbar-brand",{href:t.url},t.label)}),e.prototype.ui={brand:".navbar-brand"},e.prototype.triggers={"click @ui.brand":"click:brand"},e}(s.View),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.template=b.renderable(function(t){return b.nav("#navbar-view.navbar.navbar-static-top.navbar-default",{xmlns:"http://www.w3.org/1999/xhtml","xml:lang":"en",role:"navigation"},function(){return b.div(".container",function(){return b.div(".navbar-header"),b.div("#navbar-entries")})})}),e.prototype.regions={header:".navbar-header",usermenu:"#user-menu",mainmenu:"#main-menu",entries:"#navbar-entries"},e.prototype.onRender=function(){var t,e,n,r,i,a,p,s,l;if(this.model.get("hasUser"))for(t=u.request("main:app:object"),e=t.getState("currentUser"),s=[],l=this.model.get("navbarEntries"),a=0,p=l.length;a<p;a++)null!=(n=l[a])&&n.needUser&&!e||s.push(n);else s=this.model.get("navbarEntries");return r=new c({collection:new o.Collection(s)}),this.showChildView("entries",r),i=new y({model:new o.Model(this.model.get("brand"))}),this.showChildView("header",i)},e.prototype.onChildviewClickBrand=function(t,e){var n;return n=this.getChildView("entries"),n.setAllInactive(),this.navigateOnClickEntry(t,e)},e.prototype.navigateOnClickEntry=function(t,e){var n,o,i;return i=e.target,n=r(i).attr("href"),""===n.split("/")[0]?window.location=n:(o=u.request("main-router"),o.navigate(n,{trigger:!0}))},e}(s.View),l=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return w(e,t),e.prototype.onBeforeStart=function(){var t,e;if(t=this.options.appConfig,e=this.options.parentApp.getView().getRegion("navbar"),this.setRegion(e),t.hasUser)return this.addChildApp("user-menu",{AppClass:t.userMenuApp,startWithParent:!0,appConfig:t,parentApp:this})},e.prototype.onStart=function(){return this.initPage()},e.prototype.initPage=function(){var t,e;return t=this.options.parentApp.options.appConfig,e=new a({model:new o.Model(t)}),this.showView(e)},e}(v.App),t.exports=l},HbAm:function(t,e,n){var r,o,i,a,p=function(t,e){function n(){this.constructor=t}for(var r in e)u.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},u={}.hasOwnProperty;r=n("4kSj"),a=n("y11e"),i=Backbone.Radio.channel("global"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.el="#modal",e.prototype.backdrop=!1,e.prototype.keyboard=!1,e.prototype.getEl=function(t){var e;return e=r(t),e.attr("class","modal"),e},e.prototype.show=function(t){return e.__super__.show.call(this,t),this.$el.modal({backdrop:this.backdrop,keyboard:this.keyboard}),this.$el.modal("show")},e}(a.Region),i.reply("main:app:show-modal",function(t,e){var n,r,o;return n=i.request("main:app:object"),r=n.getView(),o=r.regions.modal,o.backdrop=!!(null!=e?e.backdrop:void 0),o.show(t)}),t.exports=o},IS1s:function(t,e,n){var r,o,i,a,p,u,s=function(t,e){function n(){this.constructor=t}for(var r in e)l.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},l={}.hasOwnProperty,c=[].indexOf||function(t){for(var e=0,n=this.length;e<n;e++)if(e in this&&this[e]===t)return e;return-1};i=n("y11e"),o=Backbone.Radio.channel("global"),a=Backbone.Radio.channel("messages"),u={},o.reply("main:applet:unregister",function(t){return delete u[t]}),o.reply("main:applet:register",function(t,e){return u[t]=e}),o.reply("main:applet:get-applet",function(t){return u[t]}),p=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.loadFrontDoor=function(){var t,e,r;return e=o.request("main:app:config"),t=(null!=e?e.frontdoorApplet:void 0)||"frontdoor",r=n("CR+N")("./"+t+"/main"),r.then(function(n){return function(n){var r;r=new n({appConfig:e,isFrontdoorApplet:!0}),o.request("main:applet:register",t,r),r.start(),Backbone.history.started||Backbone.history.start()}}())},e.prototype._handle_route=function(t,e){var r,i;if(r=o.request("main:app:config"),t||(console.warn("No applet recognized",t),t="frontdoor"),c.call(Object.keys(r.appletRoutes),t)>=0&&(t=r.appletRoutes[t],console.log("Using defined appletRoute",t)),c.call(Object.keys(u),t)>=0)throw new Error("Unhandled applet path #"+t+"/"+e);return i=n("CR+N")("./"+t+"/main"),i.then(function(e){var n;return n=new e({appConfig:r}),o.request("main:applet:register",t,n),n.start(),Backbone.history.loadUrl()}).catch(function(n){if(n.message.startsWith("Cannot find module"))return a.request("warning","Bad route "+t+", "+e+"!!");if(n.message.startsWith("Unhandled applet"))return a.request("warning",n.message);throw n})},e.prototype.routeApplet=function(t,e){var n;try{return this._handle_route(t,e)}catch(t){if(n=t,n.message.startsWith("Unhandled applet"))return a.request("warning",n.message)}},e.prototype.directLink=function(t){},e}(i.Object),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.appRoutes={"http*remainder":"directLink",":applet":"routeApplet",":applet/*path":"routeApplet"},e.prototype.onRoute=function(t,e,n){var r;"directLink"===t&&(2===n.length?(r=null!==n[1]?"http"+n.join("?"):"http"+n[0],window.open(r,"_blank")):console.log("unhandled directLink"))},e}(i.AppRouter),o.reply("main:app:route",function(){var t,e;return t=new p,e=new r({controller:t}),o.reply("main-controller",function(){return t}),o.reply("main-router",function(){return e})}),t.exports={RequireController:p,AppletRouter:r}},"TN+8":function(t,e,n){var r,o,i,a,p,u,s,l,c,f=function(t,e){function n(){this.constructor=t}for(var r in e)d.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},d={}.hasOwnProperty;r=n("aGLy"),i=n("y11e"),a=n("HWfR"),l=n("2mEY"),o=r.Radio.channel("global"),s=l.renderable(function(t){return l.li(".dropdown",function(){return l.a(".dropdown-toggle",{"data-toggle":"dropdown"},function(){return l.text(t.guestUserName),l.b(".caret")}),l.ul(".dropdown-menu",function(){return l.li(function(){return l.a({href:t.loginUrl},"login")})})})}),c=l.renderable(function(t){return l.li(".dropdown",function(){return l.a(".dropdown-toggle",{"data-toggle":"dropdown"},function(){return l.text(t.name),l.b(".caret")}),l.ul(".dropdown-menu",function(){return l.li(function(){return l.a({href:"#profile"},"User Profile")}),"admin"===t.username&&(l.li(function(){return l.a({href:"/admin"},"Administration")}),l.li(function(){return l.a({href:"#dbadmin"},"Database")})),l.li(function(){return l.a({href:"#frontdoor/logout"},"logout")})})})}),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.tagName="ul",e.prototype.className="nav navbar-nav",e.prototype.templateContext=function(){return{loginUrl:this.options.appConfig.loginUrl,guestUserName:this.options.appConfig.guestUserName,model:this.model||new r.Model,options:this.options}},e.prototype.template=function(t){return(null!=t?t.name:void 0)?(console.log("We have user: "+t.name+"!"),c(t)):(console.log("We have guest!"),s(t))},e}(i.View),p=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.onBeforeStart=function(){var t;return this.setRegion(this.options.parentApp.getView().getRegion("usermenu")),t=o.request("main:app:decode-auth-token"),console.log("TOKEN",t),this.options.user=t},e.prototype.onStart=function(){var t,e;return o,t=this.options.appConfig,e=new u({appConfig:t,model:new r.Model(this.options.user)}),this.showView(e)},e}(a.App),t.exports=p},X484:function(t,e,n){var r,o,i,a,p,u,s,l,c,f=function(t,e){function n(){this.constructor=t}for(var r in e)d.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},d={}.hasOwnProperty;r=n("aGLy"),a=n("y11e"),l=n("HWfR"),n("2mEY"),p=n("u+5S"),u=n("GSVz"),i=n("oSBz"),o=r.Radio.channel("global"),s=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.defaults={startHistory:!0,appConfig:{}},e}(r.Model),o=r.Radio.channel("global"),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.StateModel=s,e.prototype.options={appConfig:{}},e.prototype.onBeforeStart=function(){var t,e,n;if(t=this.options.appConfig,o.reply("main:app:object",function(t){return function(){return t}}(this)),o.reply("main:app:config",function(){return t}),this.setRegion(new a.Region({el:(null!=t?t.appRegion:void 0)||"body"})),e=!0,null!=t.useMessages&&!1===t.useMessages&&(e=!1),e&&this.addChildApp("messages",{AppClass:p,startWithParent:!0,parentApp:this}),n=!0,null!=t.useNavbar&&!1===t.useNavbar&&(n=!1),n)return this.addChildApp("navbar",{AppClass:u,startWithParent:!0,appConfig:t,parentApp:this})},e.prototype.initPage=function(){var t,e,n;return e=this.options.appConfig,t=(null!=e?e.layout:void 0)||i,e.layoutOptions,n=new t(e.layoutOptions),this.showView(n)},e.prototype.onStart=function(){var t;if(this.initPage(),this.getState("startHistory"))return t=o.request("main-controller"),t.loadFrontDoor()},e}(l.App),t.exports=c},oSBz:function(t,e,n){var r,o,i,a,p=function(t,e){function n(){this.constructor=t}for(var r in e)u.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},u={}.hasOwnProperty;o=n("y11e"),a=n("2mEY"),i=n("HbAm"),r=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.template=a.renderable(function(){return a.div("#navbar-view-container"),a.div(".container-fluid",function(){return a.div(".row",function(){return a.div(".col-sm-10.col-sm-offset-1",function(){return a.div("#messages")})}),a.div("#applet-content.row"),a.div("#footer.row")}),a.div("#modal")}),e.prototype.regions={messages:"#messages",navbar:"#navbar-view-container",modal:i,applet:"#applet-content",footer:"#footer"},e}(o.View),t.exports=r},"p2/H":function(t,e,n){var r,o,i,a,p,u,s,l,c,f,d,h=function(t,e){function n(){this.constructor=t}for(var r in e)y.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},y={}.hasOwnProperty;for(r=n("aGLy"),r.Radio.channel("global"),a=r.Radio.channel("messages"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.defaults={level:"info"},e}(r.Model),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return h(e,t),e.prototype.model=o,e}(r.Collection),f=new i,a.reply("messages",function(){return f}),p=function(t,e,n,r){var i,a;return null==n&&(n=!1),null==r&&(r=6e3),a=new o({content:t,level:e,icon:n}),"danger"!==e&&(i=function(){return f.remove(a)},setTimeout(i,r)),f.add(a)},a.reply("display-message",function(t,e,n){return null==e&&(e="info"),null==n&&(n=!1),console.warn("icon",n),p(t,e,n)}),d=["success","info","warning","danger"],u=function(t){return a.reply(t,function(e,n){return null==n&&(n=!1),p(e,t,n)})},s=0,l=d.length;s<l;s++)c=d[s],u(c);a.reply("delete-message",function(t){return f.remove(t)}),t.exports={BaseMessageCollection:i}},"qF/v":function(t,e,n){var r;r=n("oSBz"),t.exports={appRegion:"body",layout:r,layoutOptions:{},useMessages:!0,useNavbar:!0,brand:{label:"TBirds",url:"#"},frontdoorApplet:"frontdoor",hasUser:!1,userMenuApp:void 0,needLogin:!1,loginUrl:"/#frontdoor/login",guestUserName:"Guest",navbarEntries:[],appletRoutes:{pages:"frontdoor"}}},"u+5S":function(t,e,n){var r,o,i,a,p,u,s,l,c,f=function(t,e){function n(){this.constructor=t}for(var r in e)d.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},d={}.hasOwnProperty;r=n("aGLy"),o=n("y11e"),s=n("HWfR"),c=n("2mEY"),r.Radio.channel("global"),i=r.Radio.channel("messages"),n("p2/H"),l=c.renderable(function(t){var e;return e=t.level,"error"===e&&(e="danger"),c.div(".alert.alert-"+e,function(){var e;return c.button(".close",{type:"button","aria-hidden":!0},function(){return c.raw("&times;")}),t.icon&&(e=t.icon.startsWith("fa-")?".fa."+t.icon:".glyphicon.glyphicon-"+t.icon,c.span(e),c.raw("&nbsp;&nbsp")),c.text(t.content)})}),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.template=c.renderable(function(t){return"function"==typeof t.content?t.content(t):l(t)}),e.prototype.ui={close_button:"button.close"},e.prototype.events={"click @ui.close_button":"destroy_message"},e.prototype.destroy_message=function(){return i.request("delete-message",this.model)},e}(o.View),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.childView=a,e}(o.CollectionView),p=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return f(e,t),e.prototype.onBeforeStart=function(){return this.collection=i.request("messages"),this.setRegion(this.options.parentApp.getView().getRegion("messages"))},e.prototype.onStart=function(){return this.initPage()},e.prototype.initPage=function(){var t;return t=new u({collection:this.collection}),this.showView(t)},e}(s.App),t.exports=p}});