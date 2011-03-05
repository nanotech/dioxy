util = require 'util'
httpProxy = require 'http-proxy'

securify = (url) ->
  wikiregex = /http:\/\/(([a-z0-9]*)\.?(wikipedia|wiktionary|wikibooks|wikiquote|wikisource|wikinews|wikiversity)\.org)\/(wiki)?/
  newurl = null
  if url.match /(http:\/\/www\.google\.[a-z]+)\/(search|webhp)/
    newurl = url.replace /http:\/\/www\.google\.[a-z]+\//, 'https://encrypted.google.com/'
  else if url.match wikiregex
    newurl = url.replace(wikiregex, 'https://secure.wikimedia.org/$3/en/$4')
    lang = RegExp.$2
    if lang isnt '' and lang isnt 'en' and lang isnt 'www'
      newurl = newurl.replace '/en/', "/#{RegExp.$2}/"
    if RegExp.$4 is ''
      newurl += 'wiki'
  else if url.match /http:\/\/[a-z0-9]*\.?(youtube|twitter|facebook)\.com\//
    newurl = url.replace 'http://', 'https://'
  return newurl

httpProxy.createServer((req, res) ->
  proxy = new httpProxy.HttpProxy(req, res)
  url = req.url
  if newurl = securify url
    #util.log "#{url} -> #{newurl}"
    res.writeHead 302, 'Location': newurl
    res.write ''
    res.end()
  else
    proxy.proxyRequest(8123, 'localhost', req, res)
).listen(8742)
