class ChangeBookVersionTypeInUpdates < ActiveRecord::Migration
  def up
    change_column :updates, :book_version, :integer
  end

  def down
    change_column :updates, :book_version, :decimal, precision: 5, scale: 2
  end
end
