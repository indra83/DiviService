class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.references :course, index: true

      t.timestamps
    end
  end
end
