'use strict'
request = require('request');
cheerio = require('cheerio')
Hapi = require('hapi')

server = new (Hapi.Server)
server.connection port: 3000
server.route
  method: 'GET'
  path: '/{keyid}'
  handler: (req, reply) ->
    gnaviUrl = "http://r.gnavi.co.jp/" + req.params.keyid + "/lunch/"
    request gnaviUrl, (err, res, body) ->
      throw err if err
      $ = cheerio.load body, normalizeWhitespace: true
      fuzzyWords = $(".menu-term, .menu-desc").text().replace(/\s+/g, " ")
      reply fuzzyWords
      return
    return
server.start (err) ->
  throw err if err
  console.log 'Server running at:', server.info.uri
  return

