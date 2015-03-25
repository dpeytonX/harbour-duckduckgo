<h2>About</h2>
This is a Sailfish application which toggles the default search engine to Duck Duck GO.

<b>I can't put this on Jolla Store because among other things it writes to the .mozembed directory</b>
<p>
Download the binary from the download directory.

<h2>Update 9</h2>
This application has stopped working on Update 9 because of several changes made to the Browser application and Settings pages. A more detailed description is located <a href="https://github.com/prplmnky/harbour-duckduckgo/issues/1">here</a>
<p>
I can't say fully, but development will probably stop until I (or a contributor) has time to track this down or until Update 10 offers some mechanism to extend the search engines or provides DuckDuckGo, natively.

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
