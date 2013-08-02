class AddSchoolToClassRoom < ActiveRecord::Migration
  def change
    add_reference :class_rooms, :school, index: true
  end
end
