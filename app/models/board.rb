class Board < ActiveRecord::Base
    validates :title, presence: true
    validates :contents, presence: true
    validates :tag_list, presence: true
    acts_as_taggable
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :likes, dependent: :destroy 


    def before_post
        Board.order(created_at: :desc, id: :desc).where("created_at <= ? and id < ?", created_at, id).first
    end
    
    def next_post
        Board.order(created_at: :desc, id: :desc).where("created_at >= ? and id > ?", created_at, id).first
    end

    def like_user(user_id)
        likes.find_by(user_id: user_id)
    end
end
