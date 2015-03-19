class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.integer :pending_user_ids, array: true
      t.belongs_to :school

      t.timestamps null: false
    end
  end
end
