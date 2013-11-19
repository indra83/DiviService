class ChangeAssessmentIdTypeInSyncItems < ActiveRecord::Migration
end
  def up
    change_column :sync_items, :assessment_id, :string
  end

  def down
    change_column :sync_items, :assessment_id, :integer
  end
