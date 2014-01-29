class AddBookFromVersionToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :book_from_version, :integer
  end
end
