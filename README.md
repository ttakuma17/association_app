# README

以下記事を参考にRailsのアソシエーションについて学習をすすめる

[【初心者向け】丁寧すぎるRails『アソシエーション』チュートリアル【幾ら何でも】【完璧にわかる】🎸](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1)

---
[設計の通りに下準備](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1#%E8%A8%AD%E8%A8%88%E3%81%AE%E9%80%9A%E3%82%8A%E3%81%AB%E4%B8%8B%E6%BA%96%E5%82%99)
---
遭遇したエラー
・rails へ mysql2を入れようとしたときにエラーが発生した→ログの出力先が問題だった
   bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"
   bundle install で解決
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

実行コマンドログ
$ rails g devise:install
Running via Spring preloader in process 46722
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

ここまでの実行コマンドまとめ

Local側(Mac)の設定確認

RubyとRailsの環境確認
$ rbenv install -l
$ rbenv versions
$ gem list rails
$ gem install -v 5.2.3 rails
$ gem list rails 

MySQLの環境確認 
$ brew info mysql
$ mysql.server start
起動エラー[MySQLが起動できない エラー備忘ログ　その２](https://qiita.com/avicii2314/items/cbe938339cb80f59f5a5)
$ sudo chown -R $USER /usr/local/*
を実行してから再度startをして解消できた
$ mysql.server start -> success
$ mysql.server status -> success

Rails アプリケーションの作成
$ rails new association_app _5.2.3_ -d mysql
$ bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"
$ bundle install
$ rails g devise:install
$ rails g devise:install  # deviseの機能のインストール
$ rails g devise User  # deviseの機能を取り込んだUserモデルの作成
$ rails g controller users index show #(deviseの機能ではない)usersコントローラの作成。今回はindexとshowアクションを用意
$ rails g model Tweet body:text user_id:integer # 要件通りにカラムとその型も一緒に定義。
$ rails g controller tweets new index show create
$ rails db:create
$ rails db:migrate

---
[いよいよアソシエーションを記述しよう](https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1#%E3%81%84%E3%82%88%E3%81%84%E3%82%88%E3%82%A2%E3%82%BD%E3%82%B7%E3%82%A8%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E8%A8%98%E8%BF%B0%E3%81%97%E3%82%88%E3%81%86)
---



===============================================================================
初期の表示
===============================================================================

Depending on your application's configuration some manual setup may be required:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

     * Required for all applications. *

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"
     
     * Not required for API-only Applications *

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

     * Not required for API-only Applications *

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views
       
     * Not required *

===============================================================================
