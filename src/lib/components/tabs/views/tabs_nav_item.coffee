import Marionettist from "marionettist"
class TabsNavItem extends Marionettist.Views.Base
  template: "components/tabs/templates/tabs_nav_item"
  className: "mnt-tabs-nav__item"
  tagName: "li"
  triggers:
    "click": "nav:item:clicked"



export default TabsNavItem
