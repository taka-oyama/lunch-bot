'use strict'
Hapi = require('hapi')
Searcher = require('./scripts/searcher')

server = new (Hapi.Server)
server.connection port: 3000
server.route
  method: 'GET'
  path: '/search/{keyword}'
  handler: (request, reply) ->
    new Searcher().search(request.params.keyword, reply)
server.route
  method: 'GET'
  path: '/create/{keyid}'
  handler: (request, reply) ->
    new Searcher().analyze(request.params.keyid, reply)
server.route
  method: 'GET'
  path: '/remove/{keyid}'
  handler: (request, reply) ->
    new Searcher().remove(request.params.keyid, reply)
server.start (err) ->
  throw err if err
  console.log 'Server running at:', server.info.uri
