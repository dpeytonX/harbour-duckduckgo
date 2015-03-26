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
                return false
            }
            return true
        }

        return _remove()
    }

    function _copy() {
        var result = pluginResource.copy(searchPlugin.absoluteFilePath)
        console.log("file was " + (result ? "copied" : "not copied"))
        if(!result) return

        try {
            result = _removeJson()
            if(!result) {
                console.log("error removing json")
                return false
            }

            searchJson.open(File.ReadOnly)
            var dataString = searchJson.readAll()
            var json = JSON.parse(dataString)
            searchJson.close()

            metadataResource.open(File.ReadOnly)
            var ddgString = metadataResource.readAll()
            ddgString = ddgString.replace("!!SEARCH_PATH!!", dirSearchJson)
            console.log(ddgString)
            var ddg = JSON.parse(ddgString)

            console.log("adding ddg to json")
            json.directories[dirSearchPlugin].engines.push(ddg)
            console.log("writing search.json")
            searchJson.open(File.WriteOnly)
            searchJson.write(JSON.stringify(json))
            searchJson.close()
        } catch(e) {
            console.error(e)
            return false
        }

        return true
    }

    function _remove() {
        var result = searchPlugin.exists ? searchPlugin.remove() : true;
        console.log("file was " + (result ? "removed" : "not removed"))
        if(!result) return

        var result = _removeJson()

        return result
    }

    function _removeJson() {
        try {
            searchJson.close()
            searchJson.open(File.ReadWrite)
            var str = searchJson.readAll()
            //console.log(str)
            var json = JSON.parse(str)
            var engines = json.directories[dirSearchPlugin].engines
            for(var i = 0;i < engines.length;i ++) {
                var engine = engines[i]
                if(engine["_name"] == "DuckDuckGo") {
                    json.directories[dirSearchPlugin].engines.splice(i,1)
                    searchJson.write(JSON.stringify(json))
                    break
                }
            }
            searchJson.close()
        } catch(e) {
            console.error(e)
            return false
        }
        return true
    }
}
