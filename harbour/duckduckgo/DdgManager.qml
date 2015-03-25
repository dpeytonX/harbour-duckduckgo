import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.duckduckgo.SailfishWidgets.FileManagement 1.3

Item {
    property File searchPlugin: File {
        fileName: dir.XdgHome + "/.mozilla/mozembed/searchplugins/duckduckgo.xml"
    }

    File {
        id: pluginResource
        fileName: ":/project/duckduckgo.xml"
    }

    Dir {
        id: dir
    }

    function toggleDuckDuckGo(enable) {
        if(enable) {
            //Read mozilla plugin file from resource
            if(!pluginResource.exists) {
                console.log("Resource file does not exist");
                return false;
            }

            // Copy file to user's home directory
            var result = pluginResource.copy(searchPlugin.absoluteFilePath)
            console.log("file was " + (result ? "copied" : "not copied"))
            return result;
        }

        var result = searchPlugin.remove();
        console.log("file was " + (result ? "removed" : "not removed"));
        return result;
    }

}
