class Like < ApplicationRecord
  belongs_to :board, counter_cache: :likes_count
  belongs_to :user

end
