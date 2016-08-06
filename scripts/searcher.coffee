request = require('request')
cheerio = require('cheerio')
elasticsearch = require('elasticsearch')
client = new elasticsearch.Client(host: 'localhost:9200', log: 'trace')

class Searcher
  constructor: (@keyid) ->

  analyze: (callback) ->
    url = "http://r.gnavi.co.jp/" + @keyid + "/lunch/"
    request url, (err, res, body) =>
      throw err if err
      text = @analyzeWords(body)
      @storeResults(text)
      callback(text)

  analyzeWords: (html) ->
    $ = cheerio.load html, normalizeWhitespace: true
    $(".menu-term, .menu-desc").text().replace(/\s+/g, " ")

  storeResults: (text) ->
    client.update({
      index: 'lunchbot',
      type: 'lunch',
      id: @keyid,
      body: {
        doc: {
          url: url,
          text: text
        },
        doc_as_upsert: true
      }
    }, (err, response) ->
        console.log response.body
    )

module.exports = Searcher
