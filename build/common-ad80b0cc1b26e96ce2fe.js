webpackJsonp([7],{"CR+N":function(t,n,e){function r(t){var n=o[t];return n?e.e(n[1]).then(function(){return e(n[0])}):Promise.reject(new Error("Cannot find module '"+t+"'."))}var o={"./bumblr/main":["Gncq",3],"./dbdocs/main":["R0Nh",6],"./ebcsv/main":["qAUr",1],"./fantasy/main":["uMKg",4],"./frontdoor/main":["dKNP",0],"./hubby/main":["DxIB",2],"./userprofile/main":["Uy6/",5]};r.keys=function(){return Object.keys(o)},t.exports=r,r.id="CR+N"},GSVz:function(t,n,e){var r,o,a,i,p,u,s,l,c,f,d,y,h,v,g,_,b,m,w=function(t,n){function e(){this.constructor=t}for(var r in n)C.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},C={}.hasOwnProperty;r=e("4kSj"),o=e("aGLy"),p=e("y11e"),h=e("HWfR"),m=e("2mEY"),i=o.Radio.channel("global"),o.Radio.channel("messages"),l=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.defaults={label:"App Label",url:"#app",single_applet:!1,applets:[],urls:[]},n}(o.Model),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.model=l,n}(o.Collection),_=new c,i.reply("navbar-entries",function(){return _}),i.reply("new-navbar-entry",function(){return new l}),i.reply("add-navbar-entry",function(t){return _.add(t)}),i.reply("add-navbar-entries",function(t){return _.add(t)}),g=m.renderable(function(t){return m.button(".navbar-toggle",{type:"button","data-toggle":"collapse","data-target":"#"+t},function(){return m.span(".sr-only","Toggle Navigation"),m.span(".icon-bar"),m.span(".icon-bar"),m.span(".icon-bar")})}),m.component(function(t,n,e){return m.a(t+".dropdown-toggle",{href:n.href,"data-toggle":"dropdown"},e)}),m.renderable(function(t){return m.div("."+(t.container||"container"),function(){return m.div(".navbar-header",function(){return g("navbar-view-collapse"),m.a(".navbar-brand",{href:"#"},"TKTest")}),m.div("#navbar-view-collapse.collapse.navbar-collapse",function(){return m.ul(".nav.navbar-nav.nav-pills",function(){}),m.ul("#user-menu.nav.navbar-nav.navbar-right"),m.div("#form-search-container")})})}),m.renderable(function(t){return m.nav("#navbar-view.navbar.navbar-static-top.navbar-default",{xmlns:"http://www.w3.org/1999/xhtml","xml:lang":"en",role:"navigation"},function(){return m.div(".container",function(){return m.div(".navbar-header",function(){return g("navbar-view-collapse"),m.a(".navbar-brand",{href:"#"},"TkTest")}),m.div("#navbar-view-collapse.collapse.navbar-collapse")})})}),v=m.renderable(function(t){return m.a(".dropdown-toggle",{role:"button","data-toggle":"dropdown"},function(){return m.text(t.label),m.b(".caret")}),m.ul(".dropdown-menu",function(){var n,e,r,o,a;for(o=t.menu,a=[],n=0,e=o.length;n<e;n++)r=o[n],a.push(m.li(function(){return m.a(".navbar-entry",{href:r.url},r.label)}));return a})}),b=m.renderable(function(t){return m.a(".navbar-entry",{href:t.url},t.label)}),d=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.model=l,n.prototype.tagName="li",n.prototype.className=function(){return this.model.has("menu")?"dropdown":void 0},n.prototype.template=m.renderable(function(t){return(null!=t?t.menu:void 0)?v(t):b(t)}),n.prototype.ui={entry:".navbar-entry"},n.prototype.triggers={"click @ui.entry":"click:entry"},n.prototype.set_active=function(){return this.$el.addClass("active")},n.prototype.unset_active=function(){return this.$el.removeClass("active"),this.$el.removeClass("open")},n}(p.View),f=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.tagName="ul",n.prototype.className="nav navbar-nav nav-pills",n.prototype.childView=d,n.prototype.setAllInactive=function(){return this.children.each(function(t){return t.unset_active()})},n.prototype.onChildviewClickEntry=function(t,n){return this.setAllInactive(),t.set_active(),this.navigateOnClickEntry(t,n)},n.prototype.navigateOnClickEntry=function(t,n){var e,o,a;return a=n.target,e=r(a).attr("href"),""===e.split("/")[0]?window.location=e:(o=i.request("main-router"),o.navigate(e,{trigger:!0}))},n}(p.CollectionView),s=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.regions={list:"#navbar-entries",userMenu:"#user-menu",search:"#form-search-container"},n.prototype.onRender=function(){var t;return t=new f({collection:this.collection}),this.showChildView("list",t)},n.prototype.template=m.renderable(function(t){return m.div("#navbar-view-collapse.collapse.navbar-collapse",function(){return m.div("#navbar-entries"),m.ul("#user-menu.nav.navbar-nav.navbar-right"),m.div("#form-search-container")})}),n.prototype.setAllInactive=function(){var t;return t=this.getChildView("list"),t.setAllInactive()},n}(p.View),y=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.template=m.renderable(function(t){return g("navbar-view-collapse"),m.a(".navbar-brand",{href:t.url},t.label)}),n.prototype.ui={brand:".navbar-brand"},n.prototype.triggers={"click @ui.brand":"click:brand"},n}(p.View),a=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.template=m.renderable(function(t){return m.nav("#navbar-view.navbar.navbar-static-top.navbar-default",{xmlns:"http://www.w3.org/1999/xhtml","xml:lang":"en",role:"navigation"},function(){return m.div(".container",function(){return m.div(".navbar-header"),m.div("#navbar-entries")})})}),n.prototype.regions={header:".navbar-header",usermenu:"#user-menu",mainmenu:"#main-menu",entries:"#navbar-entries"},n.prototype.onRender=function(){var t,n;return t=new s({collection:new o.Collection(this.model.get("navbarEntries"))}),this.showChildView("entries",t),n=new y({model:new o.Model(this.model.get("brand"))}),this.showChildView("header",n)},n.prototype.onChildviewClickBrand=function(t,n){var e;return e=this.getChildView("entries"),e.setAllInactive(),this.navigateOnClickEntry(t,n)},n.prototype.navigateOnClickEntry=function(t,n){var e,o,a;return a=n.target,e=r(a).attr("href"),""===e.split("/")[0]?window.location=e:(o=i.request("main-router"),o.navigate(e,{trigger:!0}))},n}(p.View),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.onBeforeStart=function(){var t,n;if(t=this.options.appConfig,n=this.options.parentApp.getView().getRegion("navbar"),this.setRegion(n),t.hasUser)return this.addChildApp("user-menu",{AppClass:t.userMenuApp,startWithParent:!0,appConfig:t,parentApp:this})},n.prototype.onStart=function(){return this.initPage()},n.prototype.initPage=function(){var t,n;return t=this.options.parentApp.options.appConfig,n=new a({model:new o.Model(t)}),this.showView(n)},n}(h.App),t.exports=u},HbAm:function(t,n,e){var r,o,a,i,p=function(t,n){function e(){this.constructor=t}for(var r in n)u.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},u={}.hasOwnProperty;r=e("4kSj"),i=e("y11e"),a=Backbone.Radio.channel("global"),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.el="#modal",n.prototype.backdrop=!1,n.prototype.getEl=function(t){var n;return n=r(t),n.attr("class","modal"),n},n.prototype.show=function(t){return n.__super__.show.call(this,t),this.$el.modal({backdrop:this.backdrop}),this.$el.modal("show")},n}(i.Region),a.reply("main:app:show-modal",function(t,n){var e,r,o;return e=a.request("main:app:object"),r=e.getView(),o=r.regions.modal,o.backdrop=!!(null!=n?n.backdrop:void 0),o.show(t)}),t.exports=o},IS1s:function(t,n,e){var r,o,a,i,p,u,s=function(t,n){function e(){this.constructor=t}for(var r in n)l.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},l={}.hasOwnProperty,c=[].indexOf||function(t){for(var n=0,e=this.length;n<e;n++)if(n in this&&this[n]===t)return n;return-1};a=e("y11e"),o=Backbone.Radio.channel("global"),i=Backbone.Radio.channel("messages"),u={},o.reply("main:applet:unregister",function(t){return delete u[t]}),o.reply("main:applet:register",function(t){return u[t]=!0}),p=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype._route_applet=function(t){return o.request("applet:"+t+":route")},n.prototype.loadFrontDoor=function(){var t,n,r;return n=o.request("main:app:config"),t=(null!=n?n.frontdoorApplet:void 0)||"frontdoor",r=e("CR+N")("./"+t+"/main"),r.then(function(n){return function(n){var e;e=new n,o.request("main:applet:register",t),e.start(),Backbone.history.started||Backbone.history.start()}}())},n.prototype._handle_route=function(t,n){var r,a;if(r=o.request("main:app:config"),t||(console.warn("No applet recognized",t),t="frontdoor"),c.call(Object.keys(r.appletRoutes),t)>=0&&(t=r.appletRoutes[t],console.log("Using defined appletRoute",t)),c.call(Object.keys(u),t)>=0)throw new Error("Unhandled applet path #"+t+"/"+n);return a=e("CR+N")("./"+t+"/main"),a.then(function(n){return function(n){var e;return e=new n,o.request("main:applet:register",t),e.start(),Backbone.history.loadUrl()}}()).catch(function(e){if(e.message.startsWith("Cannot find module"))return i.request("warning","Bad route "+t+", "+n+"!!");if(e.message.startsWith("Unhandled applet"))return i.request("warning",e.message);throw e})},n.prototype.routeApplet=function(t,n){var e;try{return this._handle_route(t,n)}catch(t){if(e=t,e.message.startsWith("Unhandled applet"))return i.request("warning",e.message)}},n}(a.Object),r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.appRoutes={":applet":"routeApplet",":applet/*path":"routeApplet"},n.prototype.onRoute=function(t,n,e){},n}(a.AppRouter),o.reply("main:app:route",function(){var t,n;return t=new p,n=new r({controller:t}),o.reply("main-controller",function(){return t}),o.reply("main-router",function(){return n})}),t.exports={RequireController:p,AppletRouter:r}},Oo1E:function(t,n,e){var r,o,a,i,p,u,s=function(t,n){function e(){this.constructor=t}for(var r in n)l.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},l={}.hasOwnProperty;r=e("aGLy"),o=r.Radio.channel("global"),p="/api/dev/booky",a=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.urlRoot=p+"/objects",n}(r.Model),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.url=p+"/objects",n.prototype.model=a,n}(r.Collection),o.reply("new-miscobj-collection",function(){return new i}),u=new i,o.reply("get-miscobj-collection",function(){return u}),o.reply("get-miscobj",function(t){return new a({id:t})}),o.reply("new-miscobj",function(){return new a}),t.exports=null},"TN+8":function(t,n,e){var r,o,a,i,p,u,s,l=function(t,n){function e(){this.constructor=t}for(var r in n)c.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},c={}.hasOwnProperty;r=e("aGLy"),o=e("y11e"),a=e("HWfR"),s=e("2mEY"),u=s.renderable(function(t){return s.li(".dropdown",function(){return s.a(".dropdown-toggle",{"data-toggle":"dropdown"},function(){return s.text(t.guestUserName),s.b(".caret")}),s.ul(".dropdown-menu",function(){return s.li(function(){return s.a({href:t.loginUrl},"login")})})})}),p=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return l(n,t),n.prototype.tagName="ul",n.prototype.className="nav navbar-nav",n.prototype.templateContext=function(){return{loginUrl:this.options.appConfig.loginUrl,guestUserName:this.options.appConfig.guestUserName,model:this.model||new r.Model}},n.prototype.template=function(t){return t.model.isNew()?u(t):(console.log("We have user"),u(t))},n}(o.View),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return l(n,t),n.prototype.onBeforeStart=function(){return this.setRegion(this.options.parentApp.getView().getRegion("usermenu"))},n.prototype.onStart=function(){var t,n;return t=this.options.appConfig,n=new p({appConfig:t}),this.showView(n)},n}(a.App),t.exports=i},X484:function(t,n,e){var r,o,a,i,p,u,s,l,c,f=function(t,n){function e(){this.constructor=t}for(var r in n)d.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},d={}.hasOwnProperty;r=e("aGLy"),i=e("y11e"),l=e("HWfR"),e("2mEY"),p=e("u+5S"),u=e("GSVz"),a=e("oSBz"),o=r.Radio.channel("global"),s=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.defaults={startHistory:!0,appConfig:{}},n}(r.Model),o=r.Radio.channel("global"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.StateModel=s,n.prototype.options={appConfig:{}},n.prototype.onBeforeStart=function(){var t,n,e;if(t=this.options.appConfig,o.reply("main:app:object",function(t){return function(){return t}}(this)),o.reply("main:app:config",function(){return t}),this.setRegion(new i.Region({el:(null!=t?t.appRegion:void 0)||"body"})),n=!0,null!=t.useMessages&&!1===t.useMessages&&(n=!1),n&&this.addChildApp("messages",{AppClass:p,startWithParent:!0,parentApp:this}),e=!0,null!=t.useNavbar&&!1===t.useNavbar&&(e=!1),e)return this.addChildApp("navbar",{AppClass:u,startWithParent:!0,appConfig:t,parentApp:this})},n.prototype.initPage=function(){var t,n,e;return n=this.options.appConfig,t=(null!=n?n.layout:void 0)||a,n.layoutOptions,e=new t(n.layoutOptions),this.showView(e)},n.prototype.onStart=function(){var t;if(this.initPage(),this.getState("startHistory"))return t=o.request("main-controller"),t.loadFrontDoor()},n}(l.App),t.exports=c},oSBz:function(t,n,e){var r,o,a,i,p=function(t,n){function e(){this.constructor=t}for(var r in n)u.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},u={}.hasOwnProperty;o=e("y11e"),i=e("2mEY"),a=e("HbAm"),r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.template=i.renderable(function(){return i.div("#navbar-view-container"),i.div(".container-fluid",function(){return i.div(".row",function(){return i.div(".col-sm-10.col-sm-offset-1",function(){return i.div("#messages")})}),i.div("#applet-content.row"),i.div("#footer.row")}),i.div("#modal")}),n.prototype.regions={messages:"#messages",navbar:"#navbar-view-container",modal:a,applet:"#applet-content",footer:"#footer"},n}(o.View),t.exports=r},"p2/H":function(t,n,e){var r,o,a,i,p,u,s,l,c,f,d,y=function(t,n){function e(){this.constructor=t}for(var r in n)h.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},h={}.hasOwnProperty;for(r=e("aGLy"),r.Radio.channel("global"),i=r.Radio.channel("messages"),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.defaults={level:"info"},n}(r.Model),a=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.model=o,n}(r.Collection),f=new a,i.reply("messages",function(){return f}),p=function(t){return function(t,n,e,r){var a,i;return null==e&&(e=!1),null==r&&(r=6e3),i=new o({content:t,level:n,icon:e}),"danger"!==n&&(a=function(){return f.remove(i)},setTimeout(a,r)),f.add(i)}}(),i.reply("display-message",function(t){return function(t,n,e){return null==n&&(n="info"),null==e&&(e=!1),console.warn("icon",e),p(t,n,e)}}()),d=["success","info","warning","danger"],u=function(t){return i.reply(t,function(n){return function(n,e){return null==e&&(e=!1),p(n,t,e)}}())},s=0,l=d.length;s<l;s++)c=d[s],u(c);i.reply("delete-message",function(t){return function(t){return f.remove(t)}}()),t.exports={BaseMessageCollection:a}},"qF/v":function(t,n,e){var r;r=e("oSBz"),t.exports={appRegion:"body",layout:r,layoutOptions:{},useMessages:!0,useNavbar:!0,brand:{label:"TBirds",url:"#"},frontdoorApplet:"frontdoor",hasUser:!1,userMenuApp:void 0,needLogin:!1,loginUrl:"/#frontdoor/login",guestUserName:"Guest",navbarEntries:[],appletRoutes:{pages:"frontdoor"}}},"u+5S":function(t,n,e){var r,o,a,i,p,u,s,l,c,f=function(t,n){function e(){this.constructor=t}for(var r in n)d.call(n,r)&&(t[r]=n[r]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},d={}.hasOwnProperty;r=e("aGLy"),o=e("y11e"),s=e("HWfR"),c=e("2mEY"),r.Radio.channel("global"),a=r.Radio.channel("messages"),e("p2/H"),l=c.renderable(function(t){var n;return n=t.level,"error"===n&&(n="danger"),c.div(".alert.alert-"+n,function(){return c.button(".close",{type:"button","aria-hidden":!0},function(){return c.raw("&times;")}),t.icon&&c.span(".glyphicon.glyphicon-"+t.icon),c.text(t.content)})}),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.template=l,n.prototype.ui={close_button:"button.close"},n.prototype.events={"click @ui.close_button":"destroy_message"},n.prototype.destroy_message=function(){return a.request("delete-message",this.model)},n}(o.View),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.childView=i,n}(o.CollectionView),p=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.onBeforeStart=function(){return this.collection=a.request("messages"),this.setRegion(this.options.parentApp.getView().getRegion("messages"))},n.prototype.onStart=function(){return this.initPage()},n.prototype.initPage=function(){var t;return t=new u({collection:this.collection}),this.showView(t)},n}(s.App),t.exports=p}});