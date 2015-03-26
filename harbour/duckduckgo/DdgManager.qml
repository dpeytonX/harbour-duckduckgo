import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.duckduckgo.SailfishWidgets.FileManagement 1.3
import harbour.duckduckgo.SailfishWidgets.JS 1.3
import harbour.duckduckgo.SailfishWidgets.Settings 1.3

Item {
    readonly property string dirSearchJson: dir.XdgHome + "/.mozilla/mozembed"
    readonly property string dirSearchPlugin: dirSearchJson + "/searchplugins"
    readonly property string apiString: "http://api.duckduckgo.com"
    readonly property string searchString: "https://duckduckgo.com"
    readonly property string templateString: "https://duckduckgo.com"
    readonly property alias searchPlugin: bingXml
    //property File searchPlugin: File {fileName: dirSearchPlugin + "/duckduckgo.xml"}
    //property File searchJson: File {fileName: dirSearchJson + "/search.json"}

    /*File {
        id: pluginResource
        fileName: ":/project/duckduckgo.xml"
    }

    File {
        id: metadataResource
        fileName: ":/project/duckduckgo.json"
    }*/

    Dir {
        id: dir
    }

    File {
        id: bingXml
        fileName: dirSearchPlugin + "/bing.xml"
    }

    ApplicationSettings {
        id: settings

        applicationName: "harbour-duckduckgo"
        fileName: "settings"

        property string oldJsonApi: ""
        property string oldSearchApi: ""
        property string oldTemplateApi: ""
    }

    function exists() {
        return isReadyState(false)
    }

    function isReadyState(enable) {
        if(!bingXml.exists) {
            console.log(bingXml.absoluteFilePath + " does not exist")
            return false
        }

        var searchSite = enable ? "bing" : "duckduckgo";

        bingXml.close()
        bingXml.open(File.ReadOnly)
        var bingStr = bingXml.readAll()
        bingXml.close()
        var searchArray = bingStr.match(/<SearchForm>(.*?)<\/SearchForm>/)
        if(!!!searchArray || searchArray.length <= 1 || searchArray[1].toLowerCase().indexOf(searchSite) === -1) {
            return false
        }

        searchArray = bingStr.match(/type="application\/x-suggestions.*?template="(.*?)">/)
        if(!!!searchArray || searchArray.length <= 1 || searchArray[1].toLowerCase().indexOf(searchSite) === -1) {
            return false
        }

        searchArray = bingStr.match(/type="text\/html.*?template="(.*?)">/)
        if(!!!searchArray || searchArray.length <= 1 || searchArray[1].toLowerCase().indexOf(searchSite) === -1) {
            return false
        }

        return true
    }

    function updateSearch(makeDuck) {
        if(!isReadyState(makeDuck)) return false

        bingXml.close()
        bingXml.open(File.ReadOnly)
        var bingStr = bingXml.readAll()

        // Replace SearchForm
        var searchArray = bingStr.match(/<SearchForm>(.*?)<\/SearchForm>/)
        if(!!!searchArray || searchArray.length <= 1) {
            return false
        }
        settings.oldSearchApi = makeDuck ? searchArray[1] : settings.oldSearchApi
        var oldStr = makeDuck ? settings.oldSearchApi : searchString
        var newStr = makeDuck ? searchString : settings.oldSearchApi
        bingStr = bingStr.replace("<SearchForm>" + oldStr + "</SearchForm>", "<SearchForm>" + newStr + "</SearchForm>")

        // Replace JSON API String
        searchArray = bingStr.match(/type="application\/x-suggestions.*?template="(.*?)">/)
        if(!!!searchArray || searchArray.length <= 1) {
            return false
        }
        settings.oldJsonApi = makeDuck ? searchArray[1] : settings.oldJsonApi
        var newApiString = searchArray[0].replace(searchArray[1], apiString)
        oldStr = makeDuck ? searchArray[0] : newApiString
        newStr = makeDuck ? newApiString : searchArray[0]
        bingStr = bingStr.replace(oldStr, newStr)

        // Replace Search Term URL
        searchArray = bingStr.match(/type="text\/html.*?template="(.*?)">/)
        if(!!!searchArray || searchArray.length <= 1) {
            return false
        }
        settings.oldTemplateApi = makeDuck ? searchArray[1] : settings.oldTemplateApi
        var newTemplateString = searchArray[0].replace(searchArray[1], templateString)
        oldStr = makeDuck ? searchArray[0] : newTemplateString
        newStr = makeDuck ? newTemplateString : searchArray[0]
        bingStr = bingStr.replace(oldStr, newStr)

        console.log(bingStr)
        bingXml.close()
        bingXml.open(File.WriteOnly)
        bingXml.write(bingStr)
        bingXml.close()
        return true
    }
}
