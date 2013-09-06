class User < ActiveRecord::Base
  has_secure_password
  validate :name, presence: true,
                  uniqueness: true

  before_create :generate_token

  PROFILE_PIC_OPTS = {
    h: 140,
    w: 140,
    fit: 'clip',
    format: 'jpg',
    quality: 80
  }

protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.where(token: random_token).exists?
    end
  end

  include Student
  include Teacher
end
