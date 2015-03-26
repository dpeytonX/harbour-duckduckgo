import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.duckduckgo.SailfishWidgets.FileManagement 1.3
import harbour.duckduckgo.SailfishWidgets.JS 1.3

Item {
    property string dirSearchJson: dir.XdgHome + "/.mozilla/mozembed"
    property string dirSearchPlugin: dirSearchJson + "/searchplugins"
    property File searchPlugin: File {fileName: dirSearchPlugin + "/duckduckgo.xml"}
    property File searchJson: File {fileName: dirSearchJson + "/search.json"}

    File {
        id: pluginResource
        fileName: ":/project/duckduckgo.xml"
    }

    File {
        id: metadataResource
        fileName: ":/project/duckduckgo.json"
    }

    Dir {
        id: dir
    }

    function toggleDuckDuckGo(enable) {
        if(enable) {
            //Read mozilla plugin file from resource
            if(!pluginResource.exists) {
                console.log("Resource file does not exist")
                return false
            }

            if(!metadataResource.exists) {
                console.log("Metadata file does not exist")
                return false
            }

            // Copy file to user's home directory
            if(!_copy()) {
                console.log("Copy failed. Removing")
                _remove()
            }
        }

        _remove()
    }

    function _copy() {
        var result = pluginResource.copy(searchPlugin.absoluteFilePath)
        console.log("file was " + (result ? "copied" : "not copied"))
        if(!result) return

        var json = JSON.parse(searchJson.readAll())
        var ddg = JSON.parse(metadataResource.readAll())
        console.log("adding ddg to json")
        json.directories[0].engines.push(ddg)

        console.log("writing search.json")
        searchJson.write(JSON.stringify(json))
        return true
    }

    function _remove() {
        var result = searchPlugin.remove();
        console.log("file was " + (result ? "removed" : "not removed"))
        if(!result) return

        var json = JSON.parse(searchJson.readAll())
        var engines = json.directories[0].engines
        for(var i = 0;i < engines.length;i ++) {
            var engine = engines[i]
            if(engine["_name"] == "DuckDuckGo") {
                engines = Variant.remove(engines, engine)
                searchJson.write(JSON.stringify(searchJson))
                break;
            }
        }

        return result
    }
}
