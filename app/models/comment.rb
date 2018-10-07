class Comment < ApplicationRecord
  require_dependency 'concerns/content_input_validator.rb'
  # バリデーション
  # コメント内容
  validates :content, presence: true, content_input: true
  # 関係定義
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  # リプレイ機能のため自分自身テーブルの親子関係を定義
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true
end
