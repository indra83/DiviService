class AddCourseIdToSyncItems < ActiveRecord::Migration
  def change
    add_column :sync_items, :course_id, :integer
  end
end
