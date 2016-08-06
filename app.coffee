'use strict'
Hapi = require('hapi')
Searcher = require('./scripts/searcher')

server = new (Hapi.Server)
server.connection port: 3000
server.route
  method: 'GET'
  path: '/{keyid}'
  handler: (request, reply) ->
    keyid = request.params.keyid
    if keyid != "favicon.ico"
      new Searcher(request.params.keyid).analyze(reply)
    else
      reply(null)
      return
server.start (err) ->
  throw err if err
  console.log 'Server running at:', server.info.uri
