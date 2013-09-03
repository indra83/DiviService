module Teacher
  extend ActiveSupport::Concern

  def teacher?
    role.to_s == 'teacher'
  end
end
