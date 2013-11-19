class AddDetailsToSyncItems < ActiveRecord::Migration
  def change
    change_table :sync_items do |t|
      t.integer :correct_attempts
      t.integer :wrong_attempts
      t.integer :subquestions
      t.rename :points, :total_points
    end
  end
end
