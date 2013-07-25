class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :class_room, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
