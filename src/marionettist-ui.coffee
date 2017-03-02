import Marionettist from "marionettist"
import Tabs from "./lib/components/tabs/main.coffee"
import TabsCollection from "./lib/components/tabs/entities/collections/tabs.coffee"

Marionettist.UI = new Marionettist.Module()
Marionettist.UI.reply "tabs", ->
  Tabs
Marionettist.UI.reply "tabs:entities:collections:tabs", ->
  TabsCollection

export default Marionettist
