class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.string :standard
      t.string :section

      t.timestamps
    end
  end
end
