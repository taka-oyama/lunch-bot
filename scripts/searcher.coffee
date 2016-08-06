request = require('request')
cheerio = require('cheerio')
elasticsearch = require('elasticsearch')
client = new elasticsearch.Client(host: 'localhost:9200', log: 'trace')

class Searcher
  search: (keyword, callback) ->
    client.search({
      index: 'lunchbot',
      type: 'lunch',
      body: {
        query: {
          match: {
            text: keyword
          }
        }
      }
    }).then body ->
      results = body.hits.hits
      urls = []
      results.forEach(r) -> urls.push r._source.url
      callback(urls)

  analyze: (keyid, callback) ->
    url = "http://r.gnavi.co.jp/" + keyid + "/lunch/"
    request url, (err, res, body) =>
      throw err if err
      text = @analyzeWords(body)
      @storeResults(keyid, url, text)
      callback(text)

  remove: (keyid, callback) ->
    client.delete({
      index: 'lunchbot',
      type: 'lunch',
      id: keyid
    }).then (body) -> callback(body)

  analyzeWords: (html) ->
    $ = cheerio.load html, normalizeWhitespace: true
    $(".menu-term, .menu-desc").text().replace(/\s+/g, " ")

  storeResults: (keyid, url, text) ->
    client.update({
      index: 'lunchbot',
      type: 'lunch',
      id: keyid,
      body: {
        doc: {
          url: url,
          text: text
        },
        doc_as_upsert: true
      }
    }).then console.log


module.exports = Searcher
