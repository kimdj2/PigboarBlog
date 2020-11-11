class User < ActiveRecord::Base
  #メール正規式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable
    attr_accessor :login
  
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
  def is_like? (board)
    Like.find_by(user_id: self.id, board_id: board.id).present?
  end

  private

end
