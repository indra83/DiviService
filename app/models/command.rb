class Command < ActiveRecord::Base
  belongs_to :student, class_name: :User
  belongs_to :class_room

  belongs_to :teacher, class_name: :User
  belongs_to :course
  belongs_to :book

  scope :paginated_latest, ->(time, per_page) { where(updated_at: ((time + 1)..Time.zone.now)).order('updated_at').limit(per_page) }
end
