class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :description
      t.decimal :version, precision: 5, scale: 2
      t.string :details
      t.string :file
      t.references :book, index: true

      t.timestamps
    end
  end
end
