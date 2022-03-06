class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @tweet = Tweet.new
  end

  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
  end

  def create
    @tweet = Tweet.new(tweet_params)  # フォームから送られてきたデータ(body)をストロングパラメータを経由して@tweetに代入
    @tweet.user_id = current_user.id # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    @tweet.save
    redirect_to tweets_path
  end

  private # アクセス修飾子
    def tweet_params
      params.require(:tweet).permit(:body) # tweetモデルのカラムのみを許可
    end
end
