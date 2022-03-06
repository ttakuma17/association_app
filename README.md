# README
以下記事を参考にRailsのアソシエーションについて学習をすすめる  
Railsの理解を深めるためと、AWSへのデプロイ用のアプリとして使用します。  

[【初心者向け】丁寧すぎるRails『アソシエーション』チュートリアル【幾ら何でも】【完璧にわかる】🎸](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1)

***README.mdの修正***

### アプリケーション開発の準備

[設計の通りに下準備](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1#%E8%A8%AD%E8%A8%88%E3%81%AE%E9%80%9A%E3%82%8A%E3%81%AB%E4%B8%8B%E6%BA%96%E5%82%99)  

遭遇したエラー  
・rails へ mysql2を入れようとしたときにエラーが発生した→ログの出力先が問題だった  
   `bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"`  
   `bundle install` で解決  
  [bundle install時にmysql2でエラーした時の対応](https://nyakanishi.work/bundle-install%E6%99%82%E3%81%ABmysql2%E3%81%A7%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%97%E3%81%9F%E6%99%82%E3%81%AE%E5%AF%BE%E5%BF%9C/)
・could not find generator 'device:install' のエラー→deviceではなくdevise  
  gemfile内でdeviseへ書き換えて、bundle install で解決  
  ["rails g devise:install" 実行時、"Could not find generator" というエラーになる時](https://qiita.com/Taku0055/items/0c17d6f0de7e2e8a7f96)

確認した内容  
・resourcesの意味  
[リソースベースのルーティング:railsのデフォルト](https://railsguides.jp/routing.html#%E3%83%AA%E3%82%BD%E3%83%BC%E3%82%B9%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E3%83%AB%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0-rails%E3%81%AE%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88)

・before_actionの意味  
[【Rails】 before_actionの使い方とオプションについて](https://pikawaka.com/rails/before_action)
[Railsドキュメント アクションの前に処理を実行](https://railsdoc.com/page/before_action)

・authenticate_user!の意味 deviseのメソッド  
[【rails】authenticate_user!の使い方](https://qiita.com/gogotakataka1234/items/c7d5c0b3d8953216259e)

・deviseについて  
[[*Rails*] deviseの使い方（rails5版）](https://qiita.com/cigalecigales/items/f4274088f20832252374)

・MySQLの起動エラー  
[MySQLが起動できない エラー備忘ログ　その２](https://qiita.com/avicii2314/items/cbe938339cb80f59f5a5)

ここまでの実行コマンドまとめ  
Local側(Mac)の設定確認  

RubyとRailsの環境確認  
```
$ rbenv install -l
$ rbenv versions
$ gem list rails
$ gem install -v 5.2.3 rails
$ gem list rails 
```

MySQLの環境確認  
```
$ brew info mysql
$ mysql.server start
$ sudo chown -R $USER /usr/local/*
$ mysql.server start -> success
$ mysql.server status -> success
```

Rails アプリケーションの作成  
```
$ rails new association_app _5.2.3_ -d mysql
$ bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"
$ bundle install
$ rails g devise:install  # deviseの機能のインストール
$ rails g devise User  # deviseの機能を取り込んだUserモデルの作成
$ rails g controller users index show #(deviseの機能ではない)usersコントローラの作成。今回はindexとshowアクションを用意
$ rails g model Tweet body:text user_id:integer # 要件通りにカラムとその型も一緒に定義。
$ rails g controller tweets new index show create
$ rails db:create
$ rails db:migrate
```

### アソシエーションの実装
[いよいよアソシエーションを記述しよう](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1#%E3%81%84%E3%82%88%E3%81%84%E3%82%88%E3%82%A2%E3%82%BD%E3%82%B7%E3%82%A8%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E8%A8%98%E8%BF%B0%E3%81%97%E3%82%88%E3%81%86)

 
調査した内容  
ストロングパラメータ  
[【Ruby on Rails】ストロングパラメータって何なの？](https://qiita.com/ozackiee/items/f100fd51f4839b3fdca8)
[Rails ガイド ストロングパラメータ](https://railsguides.jp/action_controller_overview.html#strong-parameters)

_pathメソッド  
[_pathメソッドと_urlメソッドの使い分け](https://qiita.com/higeaaa/items/df8feaa5b6f12e13fb6f)

[Railsガイド パスとURL
用ヘルパー](https://railsguides.jp/routing.html#%E3%83%91%E3%82%B9%E3%81%A8url%E7%94%A8%E3%83%98%E3%83%AB%E3%83%91%E3%83%BC)

ここまでで1対多の実装が完了したことになる  

### 多対多のアソシエーション
[お気に入り機能の実装〜](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1#%E3%81%8A%E6%B0%97%E3%81%AB%E5%85%A5%E3%82%8A%E6%A9%9F%E8%83%BD%E3%82%92er%E5%9B%B3%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E8%A8%AD%E8%A8%88%E3%81%97%E3%82%88%E3%81%86)

多対多 の設計を実装 → 中間テーブルの登場  

調査した内容  
deviseのメソッドでどんなものが頻出なのかをよく理解できていなかったので確認  
[Rails deviseで使えるようになるヘルパーメソッド一覧](https://qiita.com/tobita0000/items/866de191635e6d74e392)

rails routesコマンドにより表示される内容の整理 項目の正確な意味を知りたいという意図  
[【Rails】 rake routesコマンドの使い方をマスターしよう！](https://pikawaka.com/rails/rake_routes)

railsのbuildメソッドとnewの違いを確認 → 結論違いは無いとのこと 
buildは、モデル内でアソシエーションを定義するときに使われる(暗黙のルール的な感じ)  
[Ruby on Rails における build メソッドと new メソッドの違い](https://qiita.com/maejimayuto/items/31c293a21c8aab1961ac)
[【Rails】モデルの関連付けで用いられるbuildメソッドまとめ](https://techtechmedia.com/build-method-rails/)

関連:rubyのeachメソッドとmapメソッドについて  
[Ruby: eachよりもmapなどのコレクションを積極的に使おう（社内勉強会）](https://techracho.bpsinc.jp/hachi8833/2020_11_06/59639)

rails sourceの意味について確認  
[Railsガイド Active Record](https://railsguides.jp/association_basics.html#has-many-through%E3%81%A8has-and-belongs-to-many%E3%81%AE%E3%81%A9%E3%81%A1%E3%82%89%E3%82%92%E9%81%B8%E3%81%B6%E3%81%8B)

ちょっとよくわからなかったので追加で以下の記事を参照。理解はした。実装となると少し苦労しそうな印象  
[ActiveRecordのhas_manyメソッドのsourceオプションについて](https://qiita.com/imotan/items/036ceffb79e294d8a063)
[ActiveRecordでhas_many, throughとは逆の関連を定義する](https://blog.toshimaru.net/belongs_to-through/)

実行したコマンド  
```
$ rails g model Favorite user_id:integer tweet_id:integer
$ rails g model Favorite user_id:integer tweet_id:integer
$ rails db:migrate
```

### 自己結合アソシエーション

[フォロー、フォロワー機能をER図を使って設計しよう](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1#%E3%83%95%E3%82%A9%E3%83%AD%E3%83%BC%E3%83%95%E3%82%A9%E3%83%AD%E3%83%AF%E3%83%BC%E6%A9%9F%E8%83%BD%E3%82%92er%E5%9B%B3%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E8%A8%AD%E8%A8%88%E3%81%97%E3%82%88%E3%81%86)

多対多のモデル(自己結合アソシエーション)  
Userモデルが1つしかないので、フォローする側、された側の判別ができない状況　→　困った  
自己結合アソシエーションは 1対多 でもありうるので認識しておくこと  


調査内容  
ルーティングのmemberメソッドについて確認  
[Railsのroutesにつけるmemberってやつ](https://qiita.com/ryuuuuuuuuuu/items/607bf3ce92d80ceb9057)
[railsのroutes.rbのmemberとcollectionの違いは?](https://qiita.com/k152744/items/141345e34fc0095217fe)

実行コマンド  
```
$ rails g model relationship following_id:integer follower_id:integer
$ rails g controller relationships create destroy
$ rails db:migrate
```

***追加タスク 今後対応をすすめること***
1. [コメント機能も作ってみよう](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1#%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E6%A9%9F%E8%83%BD%E3%82%82%E4%BD%9C%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86) 多対多の箇所の実装から自身で対応可能なはず
2. 自己結合アソシエーション-tweetsのshowページは省略します。理屈がわかっていれば絶対にできるはずです、やってみましょう！
3. dependentオプションとscopeオプションの調査と実装
4. アプリのビューが残念なので、頃合いを見て修正すること（優先度は高くはない）
