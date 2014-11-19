class User < ActiveRecord::Base
  has_paper_trail

  alias_attribute :profile_pic, :pic
	has_many :attempts, dependent: :destroy
  has_many :commands, through: :class_rooms
  has_many :tablets

  def tablet
    tablets.order(updated_at: :desc).first
  end

  has_secure_password validations: false
  validates :name, presence: true
  #                uniqueness: true

  #before_create :generate_token
  default_value_for(:report_starts_at) { Time.zone.now }

  scope :students, -> { where(role: :student) }
  scope :teachers, -> { where(role: :teacher) }

  scope :need_pic_processing, -> { where('pic_crop_factor IS NOT NULL') }

  include Rails.application.routes.url_helpers

  def metadata=(value)
    value = begin
              JSON.parse value
            rescue
              nil
            end
    write_attribute :metadata, value
  end

  def pic_crop_factor=(value)
    value = begin
              JSON.parse value
            rescue
              nil
            end
    write_attribute :pic_crop_factor, value
  end

  def admin_path
    admin_class_room_user_path class_room, self
  end

  def authenticate(password)
    return false unless super
    generate_token && save
  end

  def pending_updates(version_defs)
    version_defs ||= []
    version_map = version_defs.inject({}) {|h, vd| h[vd["book_id"].to_i] = vd["version"].to_i ; h}
    books.map { |book|
      book.pending_updates(version_map[book.id], book_branch)
    }.flatten
  end

  delegate :battery_level, :last_check_in, :is_content_up_to_date?, to: :tablet, allow_nil: true

  def logout!
    update_attributes token: nil
  end

  def crop_and_resize_pic
    return unless pic_crop_factor
    return unless pic

    image = MiniMagick::Image.open(URI.encode pic)
    image.crop "#{pic_crop_factor['w']}x#{pic_crop_factor['h']}+#{pic_crop_factor['x']}+#{pic_crop_factor['y']}"
    image.resize '150x150'
    image.format 'jpg'
    processed_pic_name = "#{self.class.name}/#{id}/pic.jpg"

    s3_obj = S3_BUCKET.objects[processed_pic_name]
    s3_obj.write image.to_blob,
      acl: :public_read,
      content_type: 'image/jpeg; charset=binary'
    update_attributes pic_crop_factor: nil, pic: s3_obj.public_url(secure: false).to_s
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

private
  def book_branch
    {
      student: 'live',
      teacher: 'staging',
      tester: 'testing'
    }[role.to_sym]
  end

end
