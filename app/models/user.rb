class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :tweets # userはたくさんのtweetsを持ちます
  has_many :favorites # user は たくさんのfavoritesを持つ
  has_many :favorite_tweets, through: :favorites, source: :tweet
end
