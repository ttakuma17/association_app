class Favorite < ApplicationRecord
  belongs_to :user # favoritesはたくさん持たれる側
  belongs_to :tweet
end
