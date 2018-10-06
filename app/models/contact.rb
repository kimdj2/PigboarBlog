class Contact
    include ActiveModel::Model
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    attr_accessor :name, :email, :message
    validates :email, presence: true , format: { with: VALID_EMAIL_REGEX }
    validates :name, presence: true
    validates :message, presence: true
end
