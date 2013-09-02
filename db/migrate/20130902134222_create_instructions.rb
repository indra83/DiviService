class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.references :lecture, index: true
      t.string :payload

      t.timestamps
    end
  end
end
