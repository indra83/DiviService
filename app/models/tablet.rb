class Tablet < ActiveRecord::Base
  has_paper_trail

  include Rails.application.routes.url_helpers
  def admin_path
    admin_tablet_path self
  end

  belongs_to :user

  def pending_updates
    user.pending_updates(content['versions'])
  end

  def timestamps
    content['timestamps'] || Hash.new('n/a')
  end
end
