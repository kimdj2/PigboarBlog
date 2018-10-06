class Comment < ApplicationRecord
  require_dependency 'concerns/content_input_validator.rb'
  validates :content, presence: true, content_input: true
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true
end
