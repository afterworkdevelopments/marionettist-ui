import Marionettist from "marionettist"
import TabsNavItem from "./tabs_nav_item.coffee"
class TabsNav extends Marionettist.Views.Collection
  className: "mnt-tabs-nav__list"
  tagName: "ul"
  childView: TabsNavItem
  onChildviewNavItemClicked: (view)->
    @$el.find("li").removeClass("mnt-tabs-nav__item--active")
    view.$el.addClass("mnt-tabs-nav__item--active")

export default TabsNav
