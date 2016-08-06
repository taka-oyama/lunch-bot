### Lunch-Bot

nodejs 6.3.1
jdk 1.8.0
elasticsearch 2.3.5

1. elasticsearch(zip)をダウンロードして展開する
1. 日本語プラグインを入れる `bin/plugin install analysis-kuromoji`
1. 以下の設定を `config/elasticsearch.yml` に入れる

       analysis:
         analyzer:
           default:
             type: custom
             tokenizer: kuromoji_tokenizer

1. 起動 `bin/elasticsearch`
1. npm install -g hubot yo generator-hubot coffee-script
1. npm install
1. 検証ページの起動 `coffee app.coffee`
1. hubotにSLACKの環境変数を登録
   - https://github.com/slackhq/hubot-slack 参照
1. hubotを起動 `bin/hubot`

参考サイト

`http://qiita.com/mochidamochiko/items/29c2d77715d8a1ff062a`
`http://qiita.com/nakamura-tsuyoshi/items/993a4f87bcef2be59db5`
