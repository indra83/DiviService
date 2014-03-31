class Account < ActiveRecord::Base
  has_secure_password
  belongs_to :user, polymorphic: true

  def authenticate(password)
    return false unless super
    generate_token && save
    return true
  end

protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.where(token: random_token).exists?
    end
  end

end
