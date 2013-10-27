class CreateSyncItems < ActiveRecord::Migration
  def change
    create_table :sync_items do |t|
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true
      t.integer :assessment_id
      t.integer :question_id
      t.integer :points
      t.integer :attempts
      t.string :data
      t.timestamp :last_updated_at

      t.timestamps
    end
  end
end
