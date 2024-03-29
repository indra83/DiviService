class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  scope :paginated_latest, ->(time, per_page) { where("last_updated_at > ?", time).order('last_updated_at').limit(per_page) }

end
