class Cdn < ActiveRecord::Base
  has_paper_trail

  belongs_to :school

  validates :school_id, presence: true

  delegate :updates, to: :school, allow_nil: true


  include Rails.application.routes.url_helpers

  def admin_path
    admin_school_cdn_path school, self
  end

end
