class Like < ApplicationRecord
  #関係定義
  belongs_to :board, counter_cache: :likes_count
  belongs_to :user

end
