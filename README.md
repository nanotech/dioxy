dioxy
=====

_re**di**rection pr**oxy**_

It's an HTTP proxy which ensures that you're always
using the HTTPS version of a site whenever one is
available. The currently supported sites are:

* Wikipedia, Wiktionary, Wikibooks, Wikiquote,
  Wikisource, Wikinews, and Wikiversity
* Google Search
* YouTube
* Twitter

The redirection mechanism is currently monolithic, but
I might make it fancier in the future.

Installation
------------

Dependencies:

    npm install coffee-script http-proxy

dioxy expects another proxy to be running on
`localhost:8123` for it to chain to. It does not support
connecting directly at the moment.

From there you can run it through the coffee tool:

    coffee dioxy.coffee

Or, if you're running OS X, copy the launchd plist from
`extras/` to your `~/Library/LaunchAgents/` folder to
have dioxy run upon login. You will also need to change
the path to dioxy unless your name is also NanoTech.
