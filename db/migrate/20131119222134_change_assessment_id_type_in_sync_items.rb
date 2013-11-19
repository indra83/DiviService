class ChangeAssessmentIdTypeInSyncItems < ActiveRecord::Migration
  def up
    change_column :sync_items, :assessment_id, :string
  end

  def down
    change_column :sync_items, :assessment_id, :integer
  end
end
