class ChangeQuestionIdTypeInSyncItems < ActiveRecord::Migration
  def up
    change_column :sync_items, :question_id, :string
  end

  def down
    change_column :sync_items, :question_id, :integer
  end
end
