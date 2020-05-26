<h2>About</h2>
This is a Sailfish application which toggles the default search engine to Duck Duck GO.

<b>Harbour store available</b>
<p>
Download the binary from the download directory.

<h2>Update 10 and Update 12</h2>
<p>
I was able to get DuckDuckGo the default search engine by updating the Bing search plugin to route to <a href="https://duckduckgo.com">https://duckduckgo.com</a> instead. You can search DuckDuckGo by setting Bing as the default search engine in the Settings > App > Browser area.
<b> Update 11 will not work.</b> I do not have an Update 11 device to test with but Jolla QA rejected this app. Update 12 is a developer release and is what I test with, however Jolla store limits the official store binary to Update 10. For now, you can download the binary from the download directory until I update the application's release version in Harbour.

<h2>License</h2>

This project is GPLv3 unless otherwise indicated on the file itself. Files with other licenses are copyrighted to their respective owners. DuckDuckGo and the DuckDuckGo images are owned by DuckDuckGo, Inc. I am in no way affiliated with <a href="https://duckduckgo.com">DuckDuckGo</a>.

Version 2.0

<h2>Features</h2>
 - Change the browser setting to DuckDuckGo<br>
 - Provide a UI to toggle DuckDuckGo search<br>

<h2>Notes</h2>
<h3>Harbour Store</h3>
 - Remove hard coded paths to home dir (use $XDG_HOME) or FileManagment in SWL
<h3>Concerned Files</h3>
 - /home/nemo/.mozilla/mozembed/search.json
 - /home/nemo/.mozilla/mozembed/searchplugins

<br>
Copyright ©2015 Dametrious Peyton. All Rights Reserved
