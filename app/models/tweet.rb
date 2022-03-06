class Tweet < ApplicationRecord
	belongs_to :user # tweetは1つのuserへ所属します
end
