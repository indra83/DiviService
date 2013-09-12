class Cdn < ActiveRecord::Base
  belongs_to :school

  validates :school_id, presence: true

  delegate :updates, to: :school, allow_nil: true
end
