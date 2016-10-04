class Housekeeper < ActiveRecord::Base
  attr_reader :password
  validates :phone, presence: true, uniqueness: true, length: {minimum: 10, maximum: 10} 
  validates_format_of :phone, :with => /\d{10}/
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}


  after_initialize :ensure_session_token

  has_many :appointments

  def self.find_by_credentials(phone, password)
    housekeeper = Housekeeper.find_by(phone: phone)
    return nil unless housekeeper
    housekeeper.is_password?(password) ? housekeeper : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    generate_session_token
    self.save
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    # TA: This method should not set self.session_token, only return a random
    # string
    self.session_token = SecureRandom.urlsafe_base64
  end

end
