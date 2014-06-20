class Tablet < ActiveRecord::Base
  belongs_to :user

  def is_content_up_to_date?
    pending_updates.empty?
  end

  def pending_updates
    user.pending_updates(content['versions'])
  end

  alias_attribute :last_check_in, :updated_at

  def time_stamps
    content['time_stamps'] || Hash.new('n/a')
  end
end
