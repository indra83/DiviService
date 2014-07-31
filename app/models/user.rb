class User < ActiveRecord::Base
  has_paper_trail

	has_many :attempts, dependent: :destroy
  #has_many :class_room_commands, through: :class_rooms, source: :commands
  #has_many :direct_commands, class_name: :Command, foreign_key: :student_id
  has_one :tablet

  def commands
    t=Command.arel_table
    Command.where(t[:class_room_id].in(class_room_ids).or(t[:student_id].eq(id)))
  end

  has_secure_password
  validates :name, presence: true,
                  uniqueness: true

  #before_create :generate_token
  default_value_for(:report_starts_at) { Time.zone.now }

  scope :students, -> { where(role: :student) }
  scope :teachers, -> { where(role: :teacher) }

  scope :need_pic_processing, -> { where('pic_crop_factor IS NOT NULL') }

  include Rails.application.routes.url_helpers

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
    return true
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

  def process_pic
    copy_original
    crop_and_resize_pic
  end

  def copy_original
    return unless pic
    S3_BUCKET.objects[versioned_pic_key :original].write open pic
  end

  def crop_and_resize_pic
    return unless pic_crop_factor
    return unless pic

    image = MiniMagick::Image.open(URI.encode pic)
    image.crop "#{pic_crop_factor['w']}x#{pic_crop_factor['h']}+#{pic_crop_factor['x']}+#{pic_crop_factor['y']}"
    image.resize '150x150'
    image.format 'jpg'

    s3_obj = S3_BUCKET.objects[versioned_pic_key '150x150', '.jpg']
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

  def versioned_pic_key(version, ext = File.extname(pic))
    "#{base_key}/#{version}#{ext}"
  end

  def base_key
    "#{self.class.name}/#{id}/pic"
  end
end
