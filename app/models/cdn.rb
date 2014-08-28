class Cdn < ActiveRecord::Base
  has_paper_trail

  belongs_to :school

  validates :base_url, presence: true,
                       length: {minimum: 10}

  include Rails.application.routes.url_helpers

  def admin_path
    if school
      admin_school_cdn_path school, self
    else
      admin_orphan_cdn_path self
    end
  end
end
