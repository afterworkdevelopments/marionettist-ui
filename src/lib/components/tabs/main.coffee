import Marionettist from "marionettist"
import TabsCollection from "./entities/collections/tabs.coffee"
import TabsNavView from "./views/tabs_nav.coffee"
import TabsContentView from "./views/tabs_content.coffee"
class Tabs extends Marionettist.Views.Base
  template: "components/tabs/templates/layout"
  className: "mnt-tabs"

  constructor: (options =   {})->
    if options.collection? and (Marionettist._.isArray(options.collection) or options.collection instanceOf TabsCollection)
      options.collection = new TabsCollection(options.collection) if Marionettist._.isArray(options.collection)
    else
      options.collection = new TabsCollection()
    super(options)

  initialize: ->
    @tabsNavView = new TabsNavView(collection: @collection)
    @tabsContentView = new TabsContentView(collection: @collection)

  regions:
    nav: ".mnt-tabs-nav"
    content: ".mnt-tabs-content"

  onRender: ->
    @showChildView("content",@tabsContentView)
    @showChildView("nav",@tabsNavView)

  onChildviewNavItemClicked: (view)->
    @tabsContentView.$el.find(".mnt-tabs-content__item--active").removeClass("mnt-tabs-content__item--active")
    @tabsContentView.children.each (v)->
      v.$el.addClass("mnt-tabs-content__item--active") if  v.model.get("tabView")  is view.model.get("tabView")



export default Tabs
