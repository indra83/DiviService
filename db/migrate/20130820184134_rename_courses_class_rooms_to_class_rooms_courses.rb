class RenameCoursesClassRoomsToClassRoomsCourses < ActiveRecord::Migration
  def change
    rename_table :courses_class_rooms, :class_rooms_courses
  end
end
