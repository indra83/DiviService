class ClassRoom < ActiveRecord::Base
  has_paper_trail

  belongs_to :school
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :users
  has_many :lectures, dependent: :destroy
	has_many :books, through: :courses
	has_many :updates, through: :courses
  has_many :commands, dependent: :destroy

  validates :school_id, presence: true

  delegate :name, to: :school, prefix: true, allow_nil: true

  alias_method :members, :users

  def name
    "#{standard} #{section} - #{school_name}"
  end

  include Rails.application.routes.url_helpers

  def admin_path
    admin_school_class_room_path school, self
  end

  attr_accessor :allowed_app_packages_field
  def allowed_app_packages_field
    self.allowed_app_packages.join(", ") unless self.allowed_app_packages.nil?
  end

  def allowed_app_packages_field=(values)
    self.allowed_app_packages = [values.split(",").map(&:strip)].flatten.select(&:present?).uniq
  end
end
