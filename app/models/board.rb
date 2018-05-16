class Board < ApplicationRecord
    validates :title, presence: true
    validates :contents, presence: true
    acts_as_taggable
    mount_uploader :image_id, ImageUploader
end
