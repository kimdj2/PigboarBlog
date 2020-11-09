class Board < ActiveRecord::Base
    require_dependency 'concerns/content_input_validator.rb'
    # バリデーション
    # タイトル
    validates :title, presence: true
    # 内容
    validates :contents, presence: true, content_input: true
    validates :contents_html, presence: true, content_input: true
    # カテゴリ（タグリスト）
    validates :tag_list, presence: true
    # 関係定義
    acts_as_taggable
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :likes, dependent: :destroy 
    # 初期値設定
    after_initialize :init_value, unless: :persisted?

    #直前のレコードを取得する。
    def before_post
        Board.order(created_at: :desc, id: :desc).where("created_at <= ? and id < ?", created_at, id).first
    end

    #直後のレコードを取得する。
    def next_post
        Board.order(created_at: :asc, id: :asc).where("created_at >= ? and id > ?", created_at, id).first
    end

    #既にいいねしたか確認する。
    def like_user(user_id)
        likes.find_by(user_id: user_id)
    end

    #いいねの数と照会数がnilの場合、初期値として0を設定する。
    def init_value
        self.view        ||= 0           
        self.likes_count ||= 0 
    end
end
