import Marionettist from "marionettist"
import TabsContentItem from "./tabs_content_item.coffee"
class TabsContent extends Marionettist.Views.Collection
  className: "mnt-tabs-content__list"
  childView: TabsContentItem


export default TabsContent
