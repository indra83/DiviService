class RanameSyncItemsToAttempts < ActiveRecord::Migration
  def change
    rename_table :sync_items, :attempts
  end
end
