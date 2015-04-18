/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.duckduckgo 1.0
import harbour.duckduckgo.SailfishWidgets.Components 1.4
import harbour.duckduckgo.SailfishWidgets.Utilities 1.4

OrientationPage {
    id: page

    OrientationHelper {}

    DdgManager {
        id: ddg
    }

    DynamicLoader {
        id: loader

        onObjectCompleted: pageStack.push(object)
    }

    Component {
        id: aboutDialog
        AboutPage {
            description: qsTr("Configures the DuckDuckGo Search Engine")
            icon: UIConstants.appIcon
            application: UIConstants.appTitle + " " + UIConstants.appVersion
            copyrightHolder: UIConstants.appCopyright
            copyrightYear: UIConstants.appYear
            contributors: UIConstants.appAuthors
            licenses: UIConstants.appLicense
            pageTitle: UIConstants.appTitle
            projectLinks: UIConstants.appProjectInfo
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        PageColumn {
            title: qsTr("DuckDuckGo Web Search")
            id: column

            SectionHeader {
                x: Theme.paddingLarge
                text: qsTr("Search Engine")
            }

            Paragraph {
                text: qsTr("Using the Browser settings will erase your search engine preference")
                width: page.width
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: false
                id: searchButton
                text: qsTr("Loading...")

                property bool isRemove: false

                onClicked: {
                    console.log("Clicked enable button")
                    if(ddg.updateSearch(!isRemove)) {
                        cleanup(true)
                        return
                    }
                    cleanup(false)
                }
            }

            Subtext {
                id: error
                text: qsTr("An error occurred. Contact the Developer")
                width: parent.width
                visible: false
            }

            Paragraph {
                property bool extra: false

                id: suggestion
                text: qsTr("Restart the Browser in order for your settings to take effect.") + (extra ? "\n" + qsTr("Now, set Bing as the default search engine in order to use DuckDuckGo.") : "")
                width: parent.width
                visible: false
            }
        }
        PullDownMenu  {
            id:pulley

            StandardMenuItem {
                text: qsTr("About")
                onClicked: loader.create(aboutDialog, page, {})
            }
        }

    }

    Component.onCompleted: {
        var exists = ddg.exists()
        console.log("search plugin duckduckgo " + (exists ? " exists" : " does not exist"))
        toggleButton(!exists)
    }

    function cleanup(good) {
        console.log("Clean up is " + (good ? "good" : "bad"))
        error.visible = !good
        if(good) {
            suggestion.visible = true
            suggestion.extra = !searchButton.isRemove
            toggleButton(searchButton.isRemove)
        }
    }

    function toggleButton(enable){
        // Check Configuration
        console.log("Toggle button " + (enable ? "enable" : "disable"))

        if(enable) {
            searchButton.text = qsTr("Enable")
            searchButton.isRemove = false
            searchButton.enabled = true
        } else {
            searchButton.text = qsTr("Disable")
            searchButton.isRemove = true
            searchButton.enabled = true
        }

    }
}
