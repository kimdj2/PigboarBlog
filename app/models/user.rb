class User < ActiveRecord::Base
  #メール正規式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable
    attr_accessor :login
  devise :omniauthable, omniauth_providers: [:facebook,:twitter,:github]
  
  # バリデーション
  #ユーザー名
  validates :username, presence: true
  #ユーザーメール
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  #パスワード
  validates :password, presence: true

  #権限とユーザーはN:N関係
  has_and_belongs_to_many :roles
  #1:N関係定義
  #コメント
  has_many :comments, dependent: :destroy
  #いいね
  has_many :likes , dependent: :destroy

  #ユーザーに権限があるか確認
  def has_role?(name)
    self.roles.where(name: name).length > 0
  end
  #ユーザーに権限があるか確認
  def is_like? (board)
    Like.find_by(user_id: self.id, board_id: board.id).present?
  end
  # auth認証より認証された場合、該当する認証情報がない場合は向の認証情報よりユーザー情報を設定する。
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    puts auth
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        image:    auth.info.image,
        username: auth.extra.raw_info.name,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  private
  # auth認証より認証された場合、ダミのEメールを作成する。
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
