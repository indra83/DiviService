class AddStatusFieldsToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :status, :string
    add_column :updates, :strategy, :string
  end
end
