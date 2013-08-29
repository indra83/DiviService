class RenameParticipationsToClassRoomsUsers < ActiveRecord::Migration
  def change
    rename_table :participations, :class_rooms_users
  end
end
