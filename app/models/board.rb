class Board < ActiveRecord::Base
    validates :title, presence: true
    validates :contents, presence: true
    acts_as_taggable
    #mount_uploader :image_id, ImageUploader
    has_many :comments, as: :commentable, dependent: :destroy
end
