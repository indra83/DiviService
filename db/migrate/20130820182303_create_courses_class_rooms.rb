class CreateCoursesClassRooms < ActiveRecord::Migration

  class Course < ActiveRecord::Base; ; end
  class ClassRoom < ActiveRecord::Base; ; end
  class CoursesClassRoom < ActiveRecord::Base; ; end

  def change
    create_table :courses_class_rooms do |t|
      t.belongs_to :course
      t.belongs_to :class_room
    end

    Course.all.each do |course|
      CoursesClassRoom.create course_id: course.id, class_room_id: course.class_room_id
    end

    remove_column :courses, :class_room_id, :belongs_to
  end
end
