class AddDeviceIdIndexToTabletsTable < ActiveRecord::Migration
  def change
    add_index :tablets, :device_id, unique: true
  end
end
