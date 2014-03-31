class User < ActiveRecord::Base
  has_paper_trail

	has_many :attempts, dependent: :destroy
  has_many :commands, through: :class_rooms
  has_one :tablet

  has_secure_password
  validate :name, presence: true,
                  uniqueness: true

  #before_create :generate_token

  scope :students, where(role: :student)
  scope :teachers, where(role: :teacher)

  PROFILE_PIC_OPTS = {
    h: 140,
    w: 140,
    fit: 'clip',
    format: 'jpg',
    quality: 80
  }

  def profile_pic_opts
    PROFILE_PIC_OPTS
  end

  include Rails.application.routes.url_helpers

  def admin_path
    admin_class_room_user_path class_room, self
  end

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

  include Student
  include Teacher
end
