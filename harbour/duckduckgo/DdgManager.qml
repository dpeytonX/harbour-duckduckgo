import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.duckduckgo.SailfishWidgets.FileManagement 1.4
import harbour.duckduckgo.SailfishWidgets.JS 1.4
import harbour.duckduckgo.SailfishWidgets.Settings 1.4

Item {
    readonly property string dirSearchJson: dir.XdgHome + "/.mozilla/mozembed"
    readonly property string dirSearchPlugin: dirSearchJson + "/searchplugins"
    readonly property alias searchPlugin: bingXml

    Dir {
        id: dir
    }

    File {
        id: pluginResource
        fileName: ":/project/duckduckgo.xml"
    }

    File {
        id: bingXml
        fileName: dirSearchPlugin + "/bing.xml"
    }

    ApplicationSettings {
        id: settings

        applicationName: "harbour-duckduckgo"
        fileName: "settings"

        property string oldBingXml: ""
    }

    function exists() {
        bingXml.close()
        bingXml.open(File.ReadOnly)
        var bingStr = bingXml.readAll()
        bingXml.close()

        // Replace SearchForm
        var searchArray = bingStr.match(/<SearchForm>(.*?)<\/SearchForm>/)
        if(!!!searchArray || searchArray.length <= 1) {
            return false
        }

        return searchArray[1].toLowerCase().indexOf("bing") === -1
    }

    function updateSearch(makeDuck) {
        bingXml.close()
        bingXml.open(File.ReadOnly)
        var bingStr = bingXml.readAll()

        bingXml.close()
        // Replace SearchForm
        var searchArray = bingStr.match(/<SearchForm>(.*?)<\/SearchForm>/)
        if(!!!searchArray || searchArray.length <= 1) {
            return false
        }

        if(searchArray[1].toLowerCase().indexOf("bing") !== -1 && makeDuck) {
            settings.oldBingXml = bingStr
            bingXml.open(File.WriteOnly)
            pluginResource.close()
            pluginResource.open(File.ReadOnly)
            var ddgText = pluginResource.readAll()
            bingXml.write(ddgText)
            pluginResource.close()
            bingXml.close()
            return true
        } else if (searchArray[1].toLowerCase().indexOf("bing") === -1 && !makeDuck) {
            bingXml.open(File.WriteOnly)
            bingXml.write(settings.oldBingXml)
            bingXml.close()
            return true
        }
        return false
    }
}
