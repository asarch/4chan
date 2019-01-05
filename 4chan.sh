#!/bin/sh

# Let's get the raw HTML code of the catalog
wget -O - http://boards.4chan.org/s/catalog > catalog.html

# Let's split </foo><bar>, </foo> <bar> tags and save the output to the catalog2.html file:
ex catalog.html -c <<EOS
:%s/></>\\
</g
:%s/> </>\\
</g
:w catalog2.html
:q
EOS

# Let's look for the <script> tag with the "author" content and save the output to the script.html file:
grep script catalog2.html | grep author > script.html

# Let's get all the variable declaration and save it to the vars.js file:
ex script.html -c <<EOS
:s/;var/;\\
var/g
:w vars.js
EOS

# Let's look for the declaration of the object catalog and save the output to catalog.js:
grep catalog vars.js > catalog.js
