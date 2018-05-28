class Board < ActiveRecord::Base
    validates :title, presence: true
    validates :contents, presence: true
    acts_as_taggable
    #mount_uploader :image_id, ImageUploader
    belongs_to :category, class_name: 'Category', foreign_key: "categories_id"

end
