class RenameVersionColumnInUpdates < ActiveRecord::Migration
  def change
    rename_column :updates, :version, :book_version
  end
end
