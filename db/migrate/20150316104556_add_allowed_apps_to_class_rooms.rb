class AddAllowedAppsToClassRooms < ActiveRecord::Migration
  def change
    add_column :class_rooms, :allowed_app_packages, :string, array: true
  end
end
