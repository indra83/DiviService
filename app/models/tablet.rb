class Tablet < ActiveRecord::Base
  has_paper_trail

  include Rails.application.routes.url_helpers
  def admin_path
    admin_tablet_path self
  end

  belongs_to :user
  belongs_to :lab

  def is_content_up_to_date?
    pending_updates.empty?
  end

  def pending_updates
    user.pending_updates(content['versions'])
  end

  alias_attribute :last_check_in, :updated_at

  def timestamps
    content['timestamps'] || Hash.new('n/a')
  end
end
