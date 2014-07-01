class AddUpdateCachesToBooks < ActiveRecord::Migration
  def change
    add_column :books, :live_updates_start, :integer
    add_column :books, :staging_updates_start, :integer
    add_column :books, :testing_updates_start, :integer
  end
end
