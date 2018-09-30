class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable
    attr_accessor :login
  devise :omniauthable, omniauth_providers: [:facebook,:twitter,:github]
  validates :username,
  uniqueness: { case_sensitive: :false }
  validates :email, presence: true
  validates :password, presence: true

  has_and_belongs_to_many :roles
  has_many :comments, dependent: :destroy
  has_many :likes , dependent: :destroy

  def has_role?(name)
    self.roles.where(name: name).length > 0
  end

  def is_like? (board)
    Like.find_by(user_id: self.id, board_id: board.id).present?
  end
  
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

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
