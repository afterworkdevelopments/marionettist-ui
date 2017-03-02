(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['components/tabs/templates/layout'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='mnt-tabs-nav'></div>\n<div class='mnt-tabs-content'></div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);

(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['components/tabs/templates/tabs_content_item'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='mnt-tabs-content__item-region'></div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);

(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['components/tabs/templates/tabs_nav_item'] = function(context) {
    return (function() {
      var $c, $e, $o;
      $e = function(text, escape) {
        return ("" + text).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&#39;').replace(/\//g, '&#47;').replace(/"/g, '&quot;');
      };
      $c = function(text) {
        switch (text) {
          case null:
          case void 0:
            return '';
          case true:
          case false:
            return '' + text;
          default:
            return text;
        }
      };
      $o = [];
      $o.push("" + $e($c(this.label)));
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '');
    }).call(context);
  };

}).call(this);
