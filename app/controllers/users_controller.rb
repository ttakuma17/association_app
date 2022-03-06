class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
    @favorite_tweets = @user.favorite_tweets # has_many throughの恩恵で一発でファボしたツイートを引けるようになっている
  end
end
