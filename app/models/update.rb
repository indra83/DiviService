class Update < ActiveRecord::Base
  has_paper_trail

  belongs_to :book

  validates :book_id, presence: true
  validates :status, presence: true
  validates :strategy, presence: true
  validates :book_version,  presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  after_save :build_book

  scope :latest, -> {
    order(:book_version)
  }

  scope :since, ->(v) { latest.where 'book_version >= ?', v }

  scope :rewrites, -> {
    where strategy: :replace
  }

  scope :live,    -> { where status: %w[live] }
  scope :staging, -> { where status: %w[live staging] }
  scope :testing, -> { where status: %w[live staging testing] }

  scope :copy_needed, -> { where copy: true }

  def process_file
    copy_original
    update_attributes copy: false
  end

  def copy_original
    return unless self.file
    o = S3_BUCKET.objects[versioned_file_key :original]

    t = Tempfile.new 'update_file', encoding: 'ascii-8bit'
    uri = URI(self.file)
    Net::HTTP.start(uri.host, uri.port, use_ssl: (uri.scheme == 'https')) do |http|
      req = Net::HTTP::Get.new uri
      http.request req do |res|
        res.read_body do |chunk|
          t.write chunk
        end
      end
    end
    t.rewind
    o.write t
    self.file = o.public_url(secure: false).to_s
  end

private
  def build_book
    return unless strategy == 'replace'
    book.rebuild_version_caches
  end
  def versioned_file_key(version, ext = File.extname(self.file))
    "#{base_file_key}/#{version}#{ext}"
  end

  def base_file_key
    "#{self.class.name}/#{id}/file"
  end
end
