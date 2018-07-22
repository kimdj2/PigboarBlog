class Board < ActiveRecord::Base
    validates :title, presence: true
    validates :contents, presence: true
    acts_as_taggable
    #mount_uploader :image_id, ImageUploader
    has_many :comments, as: :commentable, dependent: :destroy

    def before_post
        Board.order(created_at: :desc, id: :desc).where("created_at <= ? and id < ?", created_at, id).first
    end
    
    def next_post
        Board.order(created_at: :desc, id: :desc).where("created_at >= ? and id > ?", created_at, id).first
    end
      
end
