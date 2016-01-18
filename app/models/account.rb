class Account < ActiveRecord::Base
  has_secure_password
  before_save { |account| account.email = email.strip.downcase }	
  before_save { |account| account.name = name.strip }
  before_save :create_remember_token
  before_save :initialize_level
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50, minimum: 6 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  			uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def initialize_level
    self.level = 1
  end  

  private :create_remember_token, :initialize_level
end
