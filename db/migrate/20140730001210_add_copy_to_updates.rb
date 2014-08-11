class AddCopyToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :copy, :boolean
  end
end
