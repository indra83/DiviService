class User < ActiveRecord::Base
  has_secure_password
  validate :name, presence: true,
                  uniqueness: true

  before_create :generate_token

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.where(token: random_token).exists?
    end
  end

end
