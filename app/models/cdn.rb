class Cdn < ActiveRecord::Base
  has_paper_trail

  belongs_to :school

  #validates :school_id, presence: true
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

  def updates
    return [] unless school
    school.updates
  end
end
