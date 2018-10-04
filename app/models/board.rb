class Board < ActiveRecord::Base
    require_dependency 'concerns/content_input_validator.rb'
    validates :title, presence: true
    validates :contents, presence: true, content_input: true
    validates :tag_list, presence: true
    acts_as_taggable
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :likes, dependent: :destroy 
    has_many :tag_taggings, class_name: 'ActsAsTaggableOn::Tagging'


    def before_post
        Board.order(created_at: :desc, id: :desc).where("created_at <= ? and id < ?", created_at, id).first
    end
    
    def next_post
        Board.order(created_at: :desc, id: :desc).where("created_at >= ? and id > ?", created_at, id).first
    end

    def like_user(user_id)
        likes.find_by(user_id: user_id)
    end

    def check_contents
        if truncate(Sanitize.clean(board.contents)).trim == nil
            errors.add(:contents, "内容を入力してください。")
        end
    end
end
