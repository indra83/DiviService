class AddLabIdToTablet < ActiveRecord::Migration
  def change
    add_column :tablets, :lab_id, :integer
  end
end
