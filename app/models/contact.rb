class Contact
    #テーブルの定義モデルではないため、ActiveModelを定義
    include ActiveModel::Model
    #Eメール正規式
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #メンバー定義
    attr_accessor :name, :email, :message
    # バリデーション
    # Eメール
    validates :email, presence: true , format: { with: VALID_EMAIL_REGEX }
    # 名前
    validates :name, presence: true
    # メッセージ
    validates :message, presence: true
end
