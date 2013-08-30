class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.belongs_to :teacher, index: true
      t.belongs_to :class_room, index: true
      t.string :name
      t.datetime :start_time

      t.timestamps
    end
  end
end
