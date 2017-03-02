import Marionettist from "marionettist"
class TabsContentItem extends Marionettist.Views.Base
  template: "components/tabs/templates/tabs_content_item"
  className: "mnt-tabs-content__item"
  regions:
    content: ".mnt-tabs-content__item-region"
  onRender: ->
    @showChildView("content", @model.get("tabView")) if @model.get("tabView")?



export default TabsContentItem
