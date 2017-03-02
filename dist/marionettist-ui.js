(function (global, factory) {
	typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory(require('marionettist')) :
	typeof define === 'function' && define.amd ? define(['marionettist'], factory) :
	(global.Marionettist = factory(global.Marionettist));
}(this, (function (Marionettist) { 'use strict';

Marionettist = 'default' in Marionettist ? Marionettist['default'] : Marionettist;

var Tabs$2;
var extend$1 = function(child, parent) { for (var key in parent) { if (hasProp$1.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
var hasProp$1 = {}.hasOwnProperty;

Tabs$2 = (function(superClass) {
  extend$1(Tabs, superClass);

  function Tabs() {
    return Tabs.__super__.constructor.apply(this, arguments);
  }

  return Tabs;

})(Marionettist.Entities.Collections.Base);

var TabsCollection = Tabs$2;

var TabsNavItem;
var extend$3 = function(child, parent) { for (var key in parent) { if (hasProp$3.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
var hasProp$3 = {}.hasOwnProperty;

TabsNavItem = (function(superClass) {
  extend$3(TabsNavItem, superClass);

  function TabsNavItem() {
    return TabsNavItem.__super__.constructor.apply(this, arguments);
  }

  TabsNavItem.prototype.template = "components/tabs/templates/tabs_nav_item";

  TabsNavItem.prototype.className = "mnt-tabs-nav__item";

  TabsNavItem.prototype.tagName = "li";

  TabsNavItem.prototype.triggers = {
    "click": "nav:item:clicked"
  };

  return TabsNavItem;

})(Marionettist.Views.Base);

var TabsNavItem$1 = TabsNavItem;

var TabsNav;
var extend$2 = function(child, parent) { for (var key in parent) { if (hasProp$2.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
var hasProp$2 = {}.hasOwnProperty;

TabsNav = (function(superClass) {
  extend$2(TabsNav, superClass);

  function TabsNav() {
    return TabsNav.__super__.constructor.apply(this, arguments);
  }

  TabsNav.prototype.className = "mnt-tabs-nav__list";

  TabsNav.prototype.tagName = "ul";

  TabsNav.prototype.childView = TabsNavItem$1;

  TabsNav.prototype.onChildviewNavItemClicked = function(view) {
    this.$el.find("li").removeClass("mnt-tabs-nav__item--active");
    return view.$el.addClass("mnt-tabs-nav__item--active");
  };

  return TabsNav;

})(Marionettist.Views.Collection);

var TabsNavView = TabsNav;

var TabsContentItem;
var extend$5 = function(child, parent) { for (var key in parent) { if (hasProp$5.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
var hasProp$5 = {}.hasOwnProperty;

TabsContentItem = (function(superClass) {
  extend$5(TabsContentItem, superClass);

  function TabsContentItem() {
    return TabsContentItem.__super__.constructor.apply(this, arguments);
  }

  TabsContentItem.prototype.template = "components/tabs/templates/tabs_content_item";

  TabsContentItem.prototype.className = "mnt-tabs-content__item";

  TabsContentItem.prototype.regions = {
    content: ".mnt-tabs-content__item-region"
  };

  TabsContentItem.prototype.onRender = function() {
    if (this.model.get("tabView") != null) {
      return this.showChildView("content", this.model.get("tabView"));
    }
  };

  return TabsContentItem;

})(Marionettist.Views.Base);

var TabsContentItem$1 = TabsContentItem;

var TabsContent;
var extend$4 = function(child, parent) { for (var key in parent) { if (hasProp$4.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
var hasProp$4 = {}.hasOwnProperty;

TabsContent = (function(superClass) {
  extend$4(TabsContent, superClass);

  function TabsContent() {
    return TabsContent.__super__.constructor.apply(this, arguments);
  }

  TabsContent.prototype.className = "mnt-tabs-content__list";

  TabsContent.prototype.childView = TabsContentItem$1;

  return TabsContent;

})(Marionettist.Views.Collection);

var TabsContentView = TabsContent;

var Tabs;
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
var hasProp = {}.hasOwnProperty;

Tabs = (function(superClass) {
  extend(Tabs, superClass);

  Tabs.prototype.template = "components/tabs/templates/layout";

  Tabs.prototype.className = "mnt-tabs";

  function Tabs(options) {
    if (options == null) {
      options = {};
    }
    if ((options.collection != null) && (Marionettist._.isArray(options.collection) || options.collection(instanceOf(TabsCollection)))) {
      if (Marionettist._.isArray(options.collection)) {
        options.collection = new TabsCollection(options.collection);
      }
    } else {
      options.collection = new TabsCollection();
    }
    Tabs.__super__.constructor.call(this, options);
  }

  Tabs.prototype.initialize = function() {
    this.tabsNavView = new TabsNavView({
      collection: this.collection
    });
    return this.tabsContentView = new TabsContentView({
      collection: this.collection
    });
  };

  Tabs.prototype.regions = {
    nav: ".mnt-tabs-nav",
    content: ".mnt-tabs-content"
  };

  Tabs.prototype.onRender = function() {
    this.showChildView("content", this.tabsContentView);
    return this.showChildView("nav", this.tabsNavView);
  };

  Tabs.prototype.onChildviewNavItemClicked = function(view) {
    this.tabsContentView.$el.find(".mnt-tabs-content__item--active").removeClass("mnt-tabs-content__item--active");
    return this.tabsContentView.children.each(function(v) {
      if (v.model.get("tabView") === view.model.get("tabView")) {
        return v.$el.addClass("mnt-tabs-content__item--active");
      }
    });
  };

  return Tabs;

})(Marionettist.Views.Base);

var Tabs$1 = Tabs;

Marionettist.UI = new Marionettist.Module();

Marionettist.UI.reply("tabs", function() {
  return Tabs$1;
});

Marionettist.UI.reply("tabs:entities:collections:tabs", function() {
  return TabsCollection;
});

return Marionettist;

})));
//# sourceMappingURL=marionettist-ui.js.map
