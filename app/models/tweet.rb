class Tweet < ApplicationRecord
  belongs_to :user # tweetは1つのuserへ所属します
  has_many :favorites # tweetは複数のfavoritesを持つ

	# 下のメソッドはユーザーがツイートをお気に入りにしたかどうかを判定するメソッド 登録だけではなく解除もできないと行けないので
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
