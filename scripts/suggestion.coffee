Searcher = require('../scripts/searcher')

module.exports = (robot) ->

  robot.hear /(https?:\/\/[\w/:%#\$&\?\(\)~\.=\+\-]+)/, (msg) ->
    url = msg.match[1]
    match = /r.gnavi.co.jp\/([a-zA-Z0-9]+)/.exec(url)
    if match == null 
      return
    gid = match[1]
    new Searcher().analyze(gid, (body) -> console.log(body) )

  robot.hear /([^\s]+?)が((食べ)|(たべ)|(飲み)|(のみ))たい/, (msg) ->
    keyword = msg.match[1]
    new Searcher().search keyword, (urls) ->
      if urls.length == 0
        return
      msg.send "#{keyword}ですね！こちらはいかがでしょう？"
      urls.forEach (url) ->
        msg.send url

