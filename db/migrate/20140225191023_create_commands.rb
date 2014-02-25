class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.belongs_to :user, index: true
      t.belongs_to :class_room, index: true
      t.belongs_to :teacher, index: true
      t.belongs_to :course, index: true
      t.belongs_to :book, index: true
      t.string :item_code
      t.string :item_category
      t.string :category
      t.string :status
      t.json :data
      t.timestamp :applied_at
      t.timestamp :ends_at

      t.timestamps
    end
  end
end
