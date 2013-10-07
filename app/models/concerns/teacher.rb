module Teacher
  extend ActiveSupport::Concern

  included do
    has_many :delivering_lectures, class_name: 'Lecture', inverse_of: :teacher, foreign_key: :teacher_id, dependent: :destroy
  end

  def teacher?
    role.to_s == 'teacher'
  end
end
