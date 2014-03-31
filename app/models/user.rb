class User < ActiveRecord::Base
  has_paper_trail

  has_one :account, as: :user

	has_many :sync_items, dependent: :destroy
  has_many :commands, dependent: :destroy
  has_one :tablet

  validate :name, presence: true,
                  uniqueness: true

  #before_create :generate_token

  scope :students, where(role: :student)
  scope :teachers, where(role: :teacher)

  delegate :token, to: :account

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

  include Student
  include Teacher
end
