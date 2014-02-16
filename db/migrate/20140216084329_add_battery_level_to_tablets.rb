class AddBatteryLevelToTablets < ActiveRecord::Migration
  def change
    add_column :tablets, :battery_level, :integer
  end
end
